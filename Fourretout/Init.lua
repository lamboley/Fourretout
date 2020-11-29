--[[
    ~AddOn Engine~
    To load the AddOn engine add this to the top of your file:
        local E, L, P, G = unpack(select(2, ...)); -- Import: Engine, Locales, ProfileDB, GlobalDB

    To load the AddOn engine inside another addon add this to the top of your file:
        local E, L, P, G = unpack(Fourretout); -- Import: Engine, Locales, ProfileDB, GlobalDB
]]

-- GLOBALS: FourretoutDB, FourretoutCharacterDB

_G.BINDING_HEADER_FOURRETOUT = GetAddOnMetadata(..., 'Title')

local AceAddon, AceAddonMinor = _G.LibStub('AceAddon-3.0')

local addonName, Engine = ...
local E = AceAddon:NewAddon(addonName, 'AceConsole-3.0', 'AceEvent-3.0')

E.DF = { profile = {}, global = {} }
E.privateVars = { profile = {} }
E.Options = { type = 'group', args = {}, childGroups = 'Fourretout_HiddenTree'}

Engine[1] = E            -- E, Engine
Engine[2] = {}           -- L, Locales
Engine[3] = E.DF.profile -- P, ProfileDB
Engine[4] = E.DF.global  -- G, GlobalDB

_G[addonName] = Engine

E.Miscellaneous = E:NewModule('Miscellaneous','AceEvent-3.0')
E.MoutSummonEnhanced = E:NewModule('MoutSummonEnhanced')
E.EnhanceLoot = E:NewModule('EnhanceLoot','AceEvent-3.0')
E.AutoSell = E:NewModule('AutoSell','AceEvent-3.0')
E.Blizzard = E:NewModule('Blizzard','AceEvent-3.0')

do
    E.Libs = {}
    E.LibsMinor = {}
    function E:AddLib(name, major, minor)
        if not name then return end

        if type(major) == 'table' and type(minor) == 'number' then
            E.Libs[name], E.LibsMinor[name] = major, minor
        else
            E.Libs[name], E.LibsMinor[name] = _G.LibStub(major, minor)
        end
    end

    E:AddLib('AceAddon', AceAddon, AceAddonMinor)
    E:AddLib('AceDB', 'AceDB-3.0')
    E:AddLib('ACL', 'AceLocale-3.0')
    E:AddLib('DualSpec', 'LibDualSpec-1.0')
end

function E:OnEnable()
    E:Initialize()
end

function E:OnInitialize()
    if not FourretoutCharacterDB then
        FourretoutCharacterDB = {}
    end

    E.db = E:CopyTable({}, E.DF.profile)
    E.global = E:CopyTable({}, E.DF.global)

    if FourretoutDB then
        if FourretoutDB.global then
            E:CopyTable(E.global, FourretoutDB.global)
        end

        local key = FourretoutDB.profileKeys and FourretoutDB.profileKeys[E.myNameRealm]
        if key and FourretoutDB.profiles and FourretoutDB.profiles[key] then
            E:CopyTable(E.db, FourretoutDB.profiles[key])
        end
    end
end

function E:OnProfileChanged(event)
    if event == 'OnProfileChanged' then E:UpdateDB() end
end

function E:OnProfileCopied()
end

function E:OnProfileReset()
end
