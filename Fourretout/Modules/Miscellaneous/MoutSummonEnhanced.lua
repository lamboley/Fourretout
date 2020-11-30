local E, L = unpack(select(2, ...))
local MSE = E:GetModule('MoutSummonEnhanced')

local tonumber = tonumber

local CanExitVehicle, VehicleExit, InCombatLockdown = CanExitVehicle, VehicleExit, InCombatLockdown
local C_MountJournalSummonByID, C_MapGetBestMapForUnit = C_MountJournal.SummonByID, C_Map.GetBestMapForUnit
local IsMounted, Dismount, IsSpellKnown, IsFlyableArea = IsMounted, Dismount, IsSpellKnown, IsFlyableArea

local mountHeirloom = {
    ['Alliance'] = 679,
    ['Horde'] = 678
}

function MSE:M()
    if CanExitVehicle() then
        VehicleExit()
    elseif IsMounted() then
        Dismount()
    elseif not InCombatLockdown() then
        if IsSpellKnown(33388) ~= true and IsSpellKnown(33391) ~= true then
                if C_MapGetBestMapForUnit('player') == 378 then
                    print(L["You can't call heirloom mount since you haven't choosen a faction."])
                else
                    C_MountJournalSummonByID(mountHeirloom[E.myFaction])
                end
        elseif (IsSpellKnown(34090) ~= true and IsSpellKnown(90266) ~= true) or (E.db.general.dontFly and E.db.general.dontFly[tostring(E:GetZoneID())]) or not IsFlyableArea() then
            C_MountJournalSummonByID(tonumber(E.db.mount.groundMount))
        else
            C_MountJournalSummonByID(tonumber(E.db.mount.flyingMount))
        end
    end
end

function MSE:Initialize()
    self.Initialized = true
end

E:RegisterModule(MSE:GetName())
