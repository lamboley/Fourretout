local E = unpack(select(2, ...))

local GetSpecialization, GetSpecializationInfo, GetInspectSpecialization = GetSpecialization, GetSpecializationInfo, GetInspectSpecialization

E.title = format('|cff1784d1%s |r', 'Fourretout')
E.version = GetAddOnMetadata('Fourretout', 'Version')
E.myFaction, E.myLocalizedFaction = UnitFactionGroup('player')
E.myLevel = UnitLevel('player')
E.myLocalizedClass, E.myClass, E.myClassID = UnitClass('player')
E.myLocalizedRace, E.myRace = UnitRace('player')
E.myName = UnitName('player')
E.myRealm = GetRealmName()
E.myNameRealm = format('%s - %s', E.myName, E.myRealm)
E.wowPatch, E.wowBuild = GetBuildInfo()
E.wowBuild = tonumber(E.wowBuild)

local frame = CreateFrame('Frame')
frame:RegisterEvent('PLAYER_LOGIN')
frame:RegisterEvent('PLAYER_TALENT_UPDATE')
frame:SetScript('OnEvent', function()
    E.mySpec = GetSpecialization()
    if E.mySpec then
        E.mySpecId = GetInspectSpecialization('player')
        E.mySpecInfo = GetSpecializationInfo(E.mySpec)
    end
end)
