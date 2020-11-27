local E = unpack(Fourretout)

local Engine = select(2, ...)

Engine[1] = {}
Engine[2] = E.Libs.ACL:GetLocale("Fourretout", E.global.general.locale or "enUS")
local _, L = Engine[1], Engine[2]

E:AddLib("AceGUI", "AceGUI-3.0")
E:AddLib("AceConfig", "AceConfig-3.0")
E:AddLib("AceConfigDialog", "AceConfigDialog-3.0")
E:AddLib("AceConfigRegistry", "AceConfigRegistry-3.0")
E:AddLib("AceDBOptions", "AceDBOptions-3.0")

E.Libs.AceConfig:RegisterOptionsTable("Fourretout", E.Options)
E.Libs.AceConfigDialog:SetDefaultSize('Fourretout', E.global.general.AceGUI.width, E.global.general.AceGUI.height)
E.Libs.AceConfig:RegisterOptionsTable("Fourretout", E.Options)
E.Options.name = format('%s: |cff99ff33%s|r', L["Version"], E.version)

E.Options.args.profile = E.Libs.AceDBOptions:GetOptionsTable(E.data)
E.Options.args.profile.name = L["Profile"]
E.Options.args.profile.order = 1
E.Libs.AceConfig:RegisterOptionsTable('FourretoutProfiles', E.Options.args.profile)
E.Libs.DualSpec:EnhanceOptions(E.Options.args.profile, E.data)
