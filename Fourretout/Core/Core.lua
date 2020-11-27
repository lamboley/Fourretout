local Fourretout = select(2, ...)
Fourretout[2] = Fourretout[1].Libs.ACL:GetLocale('Fourretout', GetLocale())
local E, L, V, P, G = unpack(Fourretout)

local _G = _G
local type, pairs = type, pairs
local xpcall = xpcall

local ReloadUI = ReloadUI

E.myName = UnitName('player')
E.myRealm = GetRealmName()
E.myNameRealm = format('%s - %s', E.myName, E.myRealm)

E.RegisteredModules = {}
E.RegisteredInitialModules = {}

function E:CopyTable(current, default)
    if type(current) ~= 'table' then
        current = {}
    end

    if type(default) == 'table' then
        for option, value in pairs(default) do
            current[option] = (type(value) == 'table' and E:CopyTable(current[option], value)) or value
        end
    end

    return current
end

do
    function E:CallLoadFunc(func, ...)
        xpcall(func, errorhandler, ...)
    end
end

function E:CallLoadedModule(obj, silent, object, index)
    local name, func
    if type(obj) == 'table' then name, func = unpack(obj) else name = obj end
    local module = name and E:GetModule(name, silent)

    if not module then return end
    if func and type(func) == 'string' then
        E:CallLoadFunc(module[func], module)
    elseif func and type(func) == 'function' then
        E:CallLoadFunc(func, module)
    elseif module.Initialize then
        E:CallLoadFunc(module.Initialize, module)
    end

    if object and index then object[index] = nil end
end

function E:InitializeModules()
    for index, object in ipairs(E.RegisteredModules) do
        E:CallLoadedModule(object, true, E.RegisteredModules, index)
    end
end

function E:RegisterModule(name, func)
    if E.initialized then
        E:CallLoadedModule((func and {name, func}) or name)
    else
        E.RegisteredModules[#E.RegisteredModules + 1] = (func and {name, func}) or name
    end
end


function E:Initialize()
    wipe(E.db)
    wipe(E.global)
    wipe(E.private)

    local playerGUID = UnitGUID('player')
    local _, serverID = strsplit('-', playerGUID)
    E.serverID = tonumber(serverID)
    E.myGuid = playerGUID

    E.data = E.Libs.AceDB:New('FourretoutDB', E.DF, true)
    E.data.RegisterCallback(E, 'OnProfileChanged', ReloadUI)
    E.data.RegisterCallback(E, 'OnProfileCopied', ReloadUI)
    E.data.RegisterCallback(E, 'OnProfileReset', 'OnProfileReset')
    E.charSettings = E.Libs.AceDB:New('FourretoutPrivateDB', E.privateVars)
    E.charSettings.RegisterCallback(E, 'OnProfileChanged', ReloadUI)
    E.charSettings.RegisterCallback(E, 'OnProfileCopied', ReloadUI)
    E.charSettings.RegisterCallback(E, 'OnProfileReset', 'OnPrivateProfileReset')
    E.private = E.charSettings.profile
    E.global = E.data.global
    E.db = E.data.profile
    E.Libs.DualSpec:EnhanceDatabase(E.data, 'Fourretout')

    --E:DBConversions()
    --E:UIScale()
    --E:BuildPrefixValues()
    --E:LoadAPI()
    --E:LoadCommands()
    E:InitializeModules()
    --E:RefreshModulesDB()
    --E:LoadMovers()
    --E:UpdateMedia()
    --E:UpdateCooldownSettings('all')
    --E:Tutorials()
    E.initialized = true

    --if E.db.general.smoothingAmount and (E.db.general.smoothingAmount ~= 0.33) then
    --    E:SetSmoothingAmount(E.db.general.smoothingAmount)
    --end

    --if not E.private.install_complete then
    --    E:Install()
    --end

    --if E:HelloKittyFixCheck() then
    --    E:HelloKittyFix()
    --end

    --if E.db.general.kittys then
    --    E:CreateKittys()
    --    E:Delay(5, E.Print, E, L["Type /hellokitty to revert to old settings."])
    --end

    if GetCVarBool('scriptProfile') then
        E:StaticPopup_Show('SCRIPT_PROFILE')
    end

    --if E.db.general.loginmessage then
    --    local msg = format(L["LOGIN_MSG"], E.version)
    --    if Chat.Initialized then msg = select(2, Chat:FindURL('CHAT_MSG_DUMMY', msg)) end
    --    print(msg)
    --    print(L["LOGIN_MSG_HELP"])
    --end
end
