local E = unpack(Fourretout)

local Engine = select(2, ...)

Engine[1] = {}
Engine[2] = E.Libs.ACL:GetLocale("Fourretout", E.global.general.locale or "enUS")
local C, L = Engine[1], Engine[2]

E:AddLib("AceGUI", "AceGUI-3.0")
E:AddLib("AceConfig", "AceConfig-3.0")
E:AddLib("AceConfigDialog", "AceConfigDialog-3.0")
E:AddLib("AceConfigRegistry", "AceConfigRegistry-3.0")
E:AddLib("AceDBOptions", "AceDBOptions-3.0")

E.Libs.AceConfig:RegisterOptionsTable("Fourretout", E.Options)
E.Options.name = format('%s: |cff99ff33%s|r', L["Version"], E.version)

--E.Options.args.profiles = ACH:Group(L["Profiles"], nil, 5, 'tab')
--E.Options.args.profiles.args.desc = ACH:Description(L["This feature will allow you to transfer settings to other characters."], 0)
--E.Options.args.profiles.args.distributeProfile = ACH:Execute(L["Share Current Profile"], L["Sends your current profile to your target."], 1, function() if not UnitExists('target') or not UnitIsPlayer('target') or not UnitIsFriend('player', 'target') or UnitIsUnit('player', 'target') then E:Print(L["You must be targeting a player."]) return end local name, server = UnitName('target') if name and (not server or server == '') then D:Distribute(name) elseif server then D:Distribute(name, true) end end, nil, nil, nil, nil, nil, function() return not E.global.general.allowDistributor end)
--E.Options.args.profiles.args.distributeGlobal = ACH:Execute(L["Share Filters"], L["Sends your filter settings to your target."], 1, function() if not UnitExists('target') or not UnitIsPlayer('target') or not UnitIsFriend('player', 'target') or UnitIsUnit('player', 'target') then E:Print(L["You must be targeting a player."]) return end local name, server = UnitName('target') if name and (not server or server == '') then D:Distribute(name, false, true) elseif server then D:Distribute(name, true, true) end end, nil, nil, nil, nil, nil, function() return not E.global.general.allowDistributor end)
--E.Options.args.profiles.args.exportProfile = ACH:Execute(L["Export Profile"], nil, 4, function() ExportImport_Open('export') end)
--E.Options.args.profiles.args.importProfile = ACH:Execute(L["Import Profile"], nil, 5, function() ExportImport_Open('import') end)
--E.Options.args.profiles.args.allowDistributor = ACH:Toggle(L["Allow Sharing"], L["Both users will need this option enabled."], 6, nil, nil, nil, function() return E.global.general.allowDistributor end, function(_, value) E.global.general.allowDistributor = value; D:UpdateSettings() end)
--E.Options.args.profiles.args.spacer = ACH:Spacer(6)

--E.Options.args.profiles.args.profile = E.Libs.AceDBOptions:GetOptionsTable(E.data)
--E.Options.args.profiles.args.private = E.Libs.AceDBOptions:GetOptionsTable(E.charSettings)
--
--E.Options.args.profiles.args.profile.name = L["Profile"]
--E.Options.args.profiles.args.profile.order = 1
--E.Options.args.profiles.args.private.name = L["Private"]
--E.Options.args.profiles.args.private.order = 2

--E.Libs.AceConfig:RegisterOptionsTable('ElvProfiles', E.Options.args.profiles.args.profile)
--E.Libs.DualSpec:EnhanceOptions(E.Options.args.profiles.args.profile, E.data)

--E.Libs.AceConfig:RegisterOptionsTable('ElvPrivates', E.Options.args.profiles.args.private)

--E.Options.args.profiles.args.private.args.choose.confirm = function(info, value)
--    if info[#info-1] == 'private' then
--        return format(L["Choosing Settings %s. This will reload the UI.\n\n Are you sure?"], value)
--    else
--        return false
--    end
--end
--
--E.Options.args.profiles.args.private.args.copyfrom.confirm = function(info, value)
--    return format(L["Copy Settings from %s. This will overwrite %s profile.\n\n Are you sure?"], value, info.handler:GetCurrentProfile())
--end
--
--if GetAddOnEnableState(nil, 'ElvUI_Config') ~= 0 then
--    E:StaticPopup_Show('ELVUI_CONFIG_FOUND')
--end
