
function getHostname()
	local f = io.popen("/bin/hostnamectl hostname")
	local hostname = f:read("*a") or ""
	f:close()
	hostname = string.gsub(hostname, "\n$", "")
	return hostname
end

if getHostname() == "biluka" then
hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@144",
    position = "0x0",
    scale    = 1.0,
})
else
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 1.0,
})
end


