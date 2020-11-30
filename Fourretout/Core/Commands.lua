local E = unpack(select(2, ...))

local C_PetJournalGetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID

function E.GetPetGUID()
    local summonedPetGUID = C_PetJournalGetSummonedPetGUID()
    if summonedPetGUID then
        print(summonedPetGUID)
    end
end

function E.ChatCommand_GetMountID(spellID)
    if spellID == nil then return end
    local mountIDs = C_MountJournal.GetMountIDs()
    for _, mountID in pairs(mountIDs) do
        local mountName, mountSpellID = C_MountJournal.GetMountInfoByID(mountID)
        if mountSpellID == tonumber(spellID) then
            print(mountName ..' '.. mountID)
        end
    end
end

function E.GetZoneID()
    return C_Map.GetBestMapForUnit('player')
end

function E:ChatCommand_ShowZoneID()
    local id = self.GetZoneID()
    print(id .. ' - ' .. C_Map.GetMapInfo(id).name)
end

function E:LoadCommands()
    self:RegisterChatCommand('petguid', 'GetPetGUID')
    self:RegisterChatCommand('mountid', 'GetMountID')
    self:RegisterChatCommand('zoneid', 'ChatCommand_ShowZoneID')

    self:RegisterChatCommand('frt', 'ToggleOptionsUI')
end
