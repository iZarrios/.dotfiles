import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/**
 * tok-speed: Shows tokens/sec in the footer status bar while streaming.
 *
 * Live estimate (during generation): counts text delta characters and divides
 * by elapsed time (~4 chars ≈ 1 English token). Smoothed with EMA.
 *
 * Final value (at message_end): uses exact completion_tokens from the provider's
 * usage.output if available, otherwise falls back to char-based estimate.
 */

const STATUS_KEY = "tok-speed";
const CHARS_PER_TOKEN = 4;
const EMA_ALPHA = 0.15;

// Minimum output tokens before we bother showing speed (avoids noise on short replies)
const MIN_TOKENS = 3;

interface SpeedState {
  startTime: number;
  totalChars: number;
  emaSpeed: number | undefined;
  lastUpdate: number;
}

export default function (pi: ExtensionAPI) {
  let currentSpeed: SpeedState | undefined;

  pi.on("message_start", async (_event, ctx) => {
    // Only track assistant messages
    currentSpeed = {
      startTime: Date.now(),
      totalChars: 0,
      emaSpeed: undefined,
      lastUpdate: 0,
    };
  });

  pi.on("message_update", async (event, ctx) => {
    if (!currentSpeed || event.message.role !== "assistant") return;

    // Count characters from text/thinking deltas for live estimation
    const ev = event.assistantMessageEvent;
    if (ev.type === "text_delta" || ev.type === "thinking_delta") {
      currentSpeed.totalChars += ev.delta.length;
    } else if (ev.type === "text_start" || ev.type === "thinking_start") {
      const content = ev.partial.content;
      for (const c of content) {
        if (c.type === "text") {
          currentSpeed.totalChars += c.text.length;
        } else if (c.type === "thinking") {
          currentSpeed.totalChars += c.thinking.length;
        }
      }
    }

    // Live speed: chars / elapsed, smoothed with EMA
    const elapsedSec = (Date.now() - currentSpeed.startTime) / 1000;
    const estimatedTokens = currentSpeed.totalChars / CHARS_PER_TOKEN;
    const rawSpeed = elapsedSec > 0 ? estimatedTokens / elapsedSec : 0;

    if (currentSpeed.emaSpeed === undefined) {
      currentSpeed.emaSpeed = rawSpeed;
    } else {
      currentSpeed.emaSpeed = EMA_ALPHA * rawSpeed + (1 - EMA_ALPHA) * currentSpeed.emaSpeed;
    }

    // Only show once we have enough output to be meaningful
    if (estimatedTokens < MIN_TOKENS) return;

    const now = Date.now();
    if (now - currentSpeed.lastUpdate < 200) return;
    currentSpeed.lastUpdate = now;

    ctx.ui.setStatus(STATUS_KEY, formatSpeed(currentSpeed.emaSpeed!));
  });

  pi.on("message_end", async (event, ctx) => {
    if (!currentSpeed || event.message.role !== "assistant") return;

    let finalTokens: number;
    const elapsedSec = (Date.now() - currentSpeed.startTime) / 1000;

    // Use exact token count from provider if available (llama.cpp, OpenAI, etc.)
    if ("usage" in event.message && event.message.usage?.output !== undefined) {
      finalTokens = event.message.usage.output;
    } else {
      // Fallback: char-based estimate
      finalTokens = Math.round(currentSpeed.totalChars / CHARS_PER_TOKEN);
    }

    // Don't show speed for very short responses
    if (finalTokens < MIN_TOKENS) {
      ctx.ui.setStatus(STATUS_KEY, undefined);
      currentSpeed = undefined;
      return;
    }

    const finalSpeed = elapsedSec > 0 ? finalTokens / elapsedSec : 0;
    ctx.ui.setStatus(STATUS_KEY, formatSpeed(finalSpeed));



    currentSpeed = undefined;
  });
}

function formatSpeed(speed: number): string {
  if (speed < 1) {
    return `⚡ ${speed.toFixed(1)} t/s`;
  } else if (speed < 100) {
    return `⚡ ${speed.toFixed(1)} tok/s`;
  } else {
    return `⚡ ${Math.round(speed)} tok/s`;
  }
}
