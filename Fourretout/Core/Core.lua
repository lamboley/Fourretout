local Fourretout = select(2, ...)
Fourretout[2] = Fourretout[1].Libs.ACL:GetLocale('Fourretout', GetLocale())
local E = unpack(Fourretout)

local _G = _G
local wipe, xpcall = wipe, xpcall
local strjoin, unpack, format, ipairs, pairs = strjoin, unpack, format, ipairs, pairs
local tonumber = tonumber

--E.title = format('|cff1784d1%s |r', 'Fourretout')
--E.version = GetAddOnMetadata('Fourretout', 'Version')
--E.myFaction, E.myLocalizedFaction = UnitFactionGroup('player')
--E.myLevel = UnitLevel('player')
--E.myLocalizedClass, E.myClass, E.myClassID = UnitClass('player')
--E.myLocalizedRace, E.myRace = UnitRace('player')
--E.myName = UnitName('player')
--E.myRealm = GetRealmName()
--E.myNameRealm = format('%s - %s', E.myName, E.myRealm)
--E.mySpec = GetSpecialization()
--E.mySpecId = GetInspectSpecialization('player')
--E.mySpecInfo = GetSpecializationInfo(E.mySpecId)
--E.wowPatch, E.wowBuild = GetBuildInfo()
--E.wowBuild = tonumber(E.wowBuild)

E.RegisteredModules = {}

function E.Print(...)
    _G.DEFAULT_CHAT_FRAME:AddMessage(strjoin('', '|cff00ff00', 'Fourretout:|r ', ...))
end

function E:CopyTable(current, default)
    if type(current) ~= 'table' then current = {} end

    if type(default) == 'table' then
        for option, value in pairs(default) do
            current[option] = (type(value) == 'table' and self:CopyTable(current[option], value)) or value
        end
    end

    return current
end

do
    function E.CallLoadFunc(func, ...)
        xpcall(func, errorhandler, ...)
    end
end

function E:CallLoadedModule(obj, silent, object, index)
    local name, func
    if type(obj) == 'table' then name, func = unpack(obj) else name = obj end
    local module = name and self:GetModule(name, silent)

    if not module then return end
    if func and type(func) == 'string' then
        self.CallLoadFunc(module[func], module)
    elseif func and type(func) == 'function' then
        self.CallLoadFunc(func, module)
    elseif module.Initialize then
        self.CallLoadFunc(module.Initialize, module)
    end

    if object and index then object[index] = nil end
end

function E:InitializeModules()
    for index, object in ipairs(self.RegisteredModules) do
        self:CallLoadedModule(object, true, self.RegisteredModules, index)
    end
end

function E:RegisterModule(name, func)
    if self.initialized then
        self:CallLoadedModule((func and {name, func}) or name)
    else
        self.RegisteredModules[#self.RegisteredModules + 1] = (func and {name, func}) or name
    end
end

function E:DBConversions()
    if self.db.dbConverted ~= self.version then
        self.db.dbConverted = self.version

        -- Will fix issues here when changing database oafter a new version
    end
end

function E:UpdateDB()
    self.db = self.data.profile
    self.global = self.data.global

    self:DBConversions()
end

function E:Initialize()
    wipe(self.db)
    wipe(self.global)

    local playerGUID = UnitGUID('player')
    local _, serverID = strsplit('-', playerGUID)
    self.serverID = tonumber(serverID)
    self.myGuid = playerGUID

    self.data = self.Libs.AceDB:New('FourretoutDB', self.DF, true)
    self.data.RegisterCallback(E, 'OnProfileChanged', 'OnProfileChanged')
    self.data.RegisterCallback(E, 'OnProfileCopied', 'OnProfileCopied')
    self.data.RegisterCallback(E, 'OnProfileReset', 'OnProfileReset')
    self.db = self.data.profile
    self.global = self.data.global
    self.Libs.DualSpec:EnhanceDatabase(self.data, 'Fourretout')

    self:DBConversions()
    self:LoadCommands()
    self:InitializeModules()

    self.initialized = true
end
