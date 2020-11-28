local E = unpack(select(2, ...))

do
    local SlashCmdList = _G.SlashCmdList
    if not SlashCmdList.RELOADUI then
        _G.SLASH_RELOADUI1 = '/rl'
        _G.SLASH_RELOADUI2 = '/reloadui'
        SlashCmdList.RELOADUI = _G.ReloadUI
    end
end

function E:GetPetGUID()
    local summonedPetGUID = C_PetJournal.GetSummonedPetGUID()
    if summonedPetGUID then
        print(summonedPetGUID)
    end
end

function E:GetMountID(spellID)
    if spellID == nil then return end
    local mountID = C_MountJournal.GetMountIDs()
    for _, mountID in pairs(mountID) do
        local mountName, mountSpellID = C_MountJournal.GetMountInfoByID(mountID)
        if mountSpellID == tonumber(spellID) then
            print(mountName ..' '.. mountID)
        end
    end
end

function E:GetZoneID()
    return C_Map.GetBestMapForUnit('player')
end

function E:ShowZoneID()
    local id = E:GetZoneID()
    print(id .. ' - ' .. C_Map.GetMapInfo(id).name)
end

function E:LoadCommands()
    self:RegisterChatCommand('petguid', 'GetPetGUID')
    self:RegisterChatCommand('mountid', 'GetMountID')
    self:RegisterChatCommand('zoneid', 'ShowZoneID')

    self:RegisterChatCommand('frt', 'ToggleOptionsUI')
end
