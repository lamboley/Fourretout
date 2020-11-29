local E, L = unpack(select(2, ...))
local MSE = E:GetModule('MoutSummonEnhanced')

local tostring = tostring

local CanExitVehicle, VehicleExit = CanExitVehicle, VehicleExit
local C_MountJournalSummonByID = C_MountJournal.SummonByID
local C_MapGetBestMapForUnit = C_Map.GetBestMapForUnit
local IsMounted, Dismount = IsMounted, Dismount
local IsSpellKnown, IsFlyableArea = IsSpellKnown, IsFlyableArea

local mountHeirloom = {
    ['Alliance'] = 679,
    ['Horde'] = 678
}

function MSE:M()
    if CanExitVehicle() then
        VehicleExit()
    elseif IsMounted() then
        Dismount()
    elseif IsSpellKnown(33388) ~= true and IsSpellKnown(33391) ~= true then -- Can't ground mount
            if C_MapGetBestMapForUnit('player') == 378 then
                print(L["You can't call heirloom mount since you haven't choosen a faction."])
            else
                C_MountJournalSummonByID(mountHeirloom[E.myFaction])
            end
    elseif (IsSpellKnown(34090) ~= true and IsSpellKnown(90266) ~= true) or (E.db.general.mapCantFly and E.db.general.mapCantFly[tostring(E:GetZoneID())]) or not IsFlyableArea() then
        C_MountJournalSummonByID(tonumber(E.db.mount.groundMount))
    else
        C_MountJournalSummonByID(tonumber(E.db.mount.flyingMount))
    end
end

function MSE:Initialize()
    self.Initialized = true
end

E:RegisterModule(MSE:GetName())
