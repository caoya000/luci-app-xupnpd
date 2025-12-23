local i18n = require "luci.i18n"

m=Map("xupnpd", i18n.translate("XUPnPd IPTV Config"))
m.description=i18n.translate("XUPnPd for IPTV DLNA Service")

m:section(SimpleSection).template="xupnpd/xupnpd_status"
s=m:section(TypedSection, "xupnpd")
s.addremove=false
s.anonymous=true

s:tab("basic", i18n.translate("Basic Setting"))
enable=s:taboption("basic", Flag, "enabled", i18n.translate("Enable"))
enable.rmempty=false
autoactivate=s:taboption("basic", Flag, "autoactivate", i18n.translate("Broadcast for LAN Only"))
autoactivate.rmempty=false

return m