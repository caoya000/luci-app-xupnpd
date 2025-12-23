local i18n = require "luci.i18n"
local fs = require "nixio.fs"
local util = require "luci.util"
local conf_path = "/usr/share/xupnpd/playlists/iptv.m3u"
local file_content = util.trim(fs.readfile(conf_path) or "")
m = Map("xupnpd", i18n.translate("IPTV M3U List"))
m.description = i18n.translate("Replace 192.168.100.1 to your router IP")
s = m:section(SimpleSection)
s.anonymous = true
o = s:option(DummyValue, "_editor_area")
o.rawhtml = true
o.value = string.format(
    '<textarea class="cbi-input-textarea" name="_file_content" id="_file_content" rows="50" wrap="off" style="width:100%%; font-family:monospace;">%s</textarea>',
    file_content
)

function m.on_after_commit(self)
    local value = self:formvalue("_file_content")

    if value then
        local content = value:gsub("\r\n", "\n")
        fs.writefile(conf_path, content)
    end
    
    luci.sys.exec("/etc/init.d/xupnpd restart >/dev/null 2>&1 &")
end

return m