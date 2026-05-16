local function getHostname()
  local f = io.popen("/bin/hostnamectl hostname")
  if f == nil then
    return ""
  end
  local hostname = f:read("*a") or ""
  f:close()
  hostname = string.gsub(hostname, "\n$", "")
  return hostname
end

local hostname = getHostname()

if hostname == "biluka" then
  hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@144.00",
    position = "0x0",
    scale    = 1.0,
  })
elseif hostname == "pavi" then
  hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 1.0,
  })
end
