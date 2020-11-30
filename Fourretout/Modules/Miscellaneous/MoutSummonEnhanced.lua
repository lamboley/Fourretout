local E, L = unpack(select(2, ...))
local MSE = E:GetModule('MoutSummonEnhanced')

local tonumber, tostring = tonumber, tostring

local CanExitVehicle, VehicleExit, InCombatLockdown = CanExitVehicle, VehicleExit, InCombatLockdown
local C_MountJournalSummonByID, C_MapGetBestMapForUnit = C_MountJournal.SummonByID, C_Map.GetBestMapForUnit
local IsMounted, Dismount, IsSpellKnown, IsFlyableArea = IsMounted, Dismount, IsSpellKnown, IsFlyableArea

local mountHeirloom = {
    ['Alliance'] = 679,
    ['Horde'] = 678
}

function MSE:UpdateMountSpell()
    self.apprentiRiding = IsSpellKnown(33388)
    self.companionRiding = IsSpellKnown(33391)
    self.expertRiding = IsSpellKnown(34090)
    self.masterRiding = IsSpellKnown(90265)
end

function MSE:LEARNED_SPELL_IN_TAB()
    self:UpdateMountSpell()
end

function MSE:M()
    if CanExitVehicle() then
        VehicleExit()
    elseif IsMounted() then
        Dismount()
    elseif not InCombatLockdown() then
        if (not self.expertRiding and not self.masterRiding) or (E.db.general.dontFly and E.db.general.dontFly[tostring(E.GetZoneID())]) or not IsFlyableArea() then
            if self.apprentiRiding or self.companionRiding or self.expertRiding or self.masterRiding then
                C_MountJournalSummonByID(tonumber(E.db.mount.groundMount))
            else
                if C_MapGetBestMapForUnit('player') == 378 then
                    E.Print(L["You can't call heirloom mount since you haven't choosen a faction."])
                else
                    C_MountJournalSummonByID(mountHeirloom[E.myFaction])
                end
            end
        else
            C_MountJournalSummonByID(tonumber(E.db.mount.flyingMount))
        end
    end
end

function MSE:Initialize()
    self.Initialized = true

    self:UpdateMountSpell()
    self:RegisterEvent('LEARNED_SPELL_IN_TAB')
end

E:RegisterModule(MSE:GetName())
