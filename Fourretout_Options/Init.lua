local E = unpack(Fourretout)
local Engine = select(2, ...)

Engine[1] = {}
Engine[2] = E.Libs.ACL:GetLocale('Fourretout', E.global.general.locale or 'enUS')

E:AddLib('AceGUI', 'AceGUI-3.0')
E:AddLib('AceConfig', 'AceConfig-3.0')
E:AddLib('AceConfigDialog', 'AceConfigDialog-3.0')
E:AddLib('AceConfigRegistry', 'AceConfigRegistry-3.0')
E:AddLib('AceDBOptions', 'AceDBOptions-3.0')

E.Libs.AceConfig:RegisterOptionsTable('Fourretout', E.Options)
E.Libs.AceConfigDialog:SetDefaultSize('Fourretout', E.global.general.AceGUI.width, E.global.general.AceGUI.height)

if E.version == '0.0.1' then
    E.Options.name = format('%s |cff00ff00%s|r', E.name, E.version)
else
    E.Options.name = format('%s |cffff0000%s|r', E.name, E.version)
end
