local E = unpack(select(2, ...))
local PL = E:GetModule('PetLeash')

local InCombatLockdown, IsStealthed = InCombatLockdown, IsStealthed
local C_PetJournal_GetSummonedPetGUID, C_PetJournal_SummonPetByGUID = C_PetJournal.GetSummonedPetGUID, C_PetJournal.SummonPetByGUID



function PL.UPDATE_STEALTH()
    if InCombatLockdown('player') or not IsStealthed() then return end
    if C_PetJournal_GetSummonedPetGUID() ~= nil then
        C_PetJournal_SummonPetByGUID(C_PetJournal_GetSummonedPetGUID())
    end
end

local function summonBattlePet()
    if InCombatLockdown('player') or IsStealthed() then return end
    if C_PetJournal_GetSummonedPetGUID() ~= 'BattlePet-0-00000B31A074' then
        C_PetJournal_SummonPetByGUID('BattlePet-0-00000B31A074')
    end
end

function PL.PLAYER_ENTERING_WORLD()
    summonBattlePet()
end

function PL.COMPANION_UPDATE()
    summonBattlePet()
end

function PL.ZONE_CHANGED()
    summonBattlePet()
end

function PL.ZONE_CHANGED_INDOORS()
    summonBattlePet()
end

function PL.ZONE_CHANGED_NEW_AREA()
    summonBattlePet()
end

function PL.PLAYER_UPDATE_RESTING()
    summonBattlePet()
end

function PL:Initialize()
    self.Initialized = true

    self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:RegisterEvent('COMPANION_UPDATE')
    self:RegisterEvent('ZONE_CHANGED')
    self:RegisterEvent('ZONE_CHANGED_INDOORS')
    self:RegisterEvent('ZONE_CHANGED_NEW_AREA')
    self:RegisterEvent('PLAYER_UPDATE_RESTING')
    self:RegisterEvent('UPDATE_STEALTH')
end

E:RegisterModule(PL:GetName())
