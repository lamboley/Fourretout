local Fourretout = select(2, ...)
Fourretout[2] = Fourretout[1].Libs.ACL:GetLocale('Fourretout', GetLocale())
local E = unpack(Fourretout)

E.noop = function() end
E.title = format('|cff1784d1%s |r', 'Fourretout')
E.version = GetAddOnMetadata('Fourretout', 'Version')
E.myFaction, E.myLocalizedFaction = UnitFactionGroup('player')
E.myLevel = UnitLevel('player')
E.myLocalizedClass, E.myClass, E.myClassID = UnitClass('player')
E.myLocalizedRace, E.myRace = UnitRace('player')
E.myName = UnitName('player')
E.myRealm = GetRealmName()
E.myNameRealm = format('%s - %s', E.myName, E.myRealm)
E.mySpec = GetSpecialization()
E.wowPatch, E.wowBuild = GetBuildInfo()
E.wowBuild = tonumber(E.wowBuild)

E.RegisteredModules = {}

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

function E:DBConversions()
    if E.db.dbConverted ~= E.version then
        E.db.dbConverted = E.version

        -- Will fix issues here when changing database oafter a new version
    end
end

function E:UpdateDB()
    E.db = E.data.profile
    E.global = E.data.global

    E:DBConversions()
end

function E:Initialize()
    wipe(E.db)
    wipe(E.global)

    local playerGUID = UnitGUID('player')
    local _, serverID = strsplit('-', playerGUID)
    E.serverID = tonumber(serverID)
    E.myGuid = playerGUID

    E.data = E.Libs.AceDB:New('FourretoutDB', E.DF, true)
    E.data.RegisterCallback(E, 'OnProfileChanged', 'OnProfileChanged')
    E.data.RegisterCallback(E, 'OnProfileCopied', 'OnProfileCopied')
    E.data.RegisterCallback(E, 'OnProfileReset', 'OnProfileReset')
    E.db = E.data.profile
    E.global = E.data.global
    E.Libs.DualSpec:EnhanceDatabase(E.data, 'Fourretout')

    E:DBConversions()
    E:LoadCommands()
    E:InitializeModules()

    E.initialized = true
end
