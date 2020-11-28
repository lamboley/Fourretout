local E, L, P, G = unpack(select(2, ...))
local MSE = E:GetModule('MoutSummonEnhanced')

function MSE:M(groundID, flyingID)
        if CanExitVehicle() then
            VehicleExit()
        elseif not C_MountJournal.GetNumMounts() or IsMounted() then
            Dismount()
        elseif E.db.general.mapCantFly[tostring(E:GetZoneID())] then
            C_MountJournal.SummonByID(tonumber(E.db.mount.groundMount))
        elseif IsSpellKnown(34090) ~= true and IsSpellKnown(34091) ~= true and IsSpellKnown(90265) ~= true then
            if IsSpellKnown(33388) ~= true and IsSpellKnown(33391) ~= true then
                if C_Map.GetBestMapForUnit('player') == 378 then
                    print(L["You can't call heirloom mount since you haven't choosen a faction."])
                else
                    C_MountJournal.SummonByID(C['mount']['mountHeirloom'][DB.playerFaction])
                end
            else
                C_MountJournal.SummonByID(tonumber(E.db.mount.groundMount))
            end
        elseif IsUsableSpell(93326) == true or IsFlyableArea() then
            C_MountJournal.SummonByID(tonumber(E.db.mount.flyingMount))
        else
            C_MountJournal.SummonByID(tonumber(E.db.mount.groundMount))
        end
end

function MSE:Initialize()
    self.Initialized = true
end

E:RegisterModule(MSE:GetName())
