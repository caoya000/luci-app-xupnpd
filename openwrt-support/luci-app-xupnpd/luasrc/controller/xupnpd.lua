module("luci.controller.xupnpd",package.seeall)

function index()
    if not nixio.fs.access("/etc/config/xupnpd")then
        return
    end
    entry({"admin", "services", "xupnpd"}, alias("admin", "services", "xupnpd", "settings"), _("XUPnPd IPTV"), 60).dependent = true
    entry({"admin", "services", "xupnpd", "settings"}, cbi("xupnpd"), _("XUPnPd IPTV Config"), 1).leaf=true
    entry({"admin", "services", "xupnpd", "playlist"}, cbi("xupnpd-playlist"), _("IPTV M3U Playlist"), 2).leaf = true
    entry({"admin", "services", "xupnpd", "status"}, call("act_status")).leaf=true
end

function act_status()
    local e={}
    e.running=luci.sys.call("pgrep xupnpd >/dev/null")==0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end