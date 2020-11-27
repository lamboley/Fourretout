local E, L, P, G = unpack(select(2, ...))
local MSE = E:GetModule('MoutSummonEnhanced')

local mapCantFly = {
    [112] = true, -- Eye of the Storm, PvP
    [1366] = true, -- Arathi Basin, PvP
    [1533] = true, -- Bastion, Shadowlands
    [1536] = true, -- Maldraxxus, Shadowlands
    [1670] = true, -- Oribos, Shadowlands
    [1671] = true, -- Oribos, Ring of Transference, Shadowlands
    [1707] = true, -- Elysian Hold, Bastion, Shadowlands
}

function MSE:M(groundID, flyingID)
        if CanExitVehicle() then
            VehicleExit()
        elseif not C_MountJournal.GetNumMounts() or IsMounted() then
            Dismount()
        elseif mapCantFly[C_Map.GetBestMapForUnit('player')] then
            C_MountJournal.SummonByID(tonumber(groundID))
        elseif IsSpellKnown(34090) ~= true and IsSpellKnown(34091) ~= true and IsSpellKnown(90265) ~= true then
            if IsSpellKnown(33388) ~= true and IsSpellKnown(33391) ~= true then
                if C_Map.GetBestMapForUnit('player') == 378 then
                    print(L["You can't call heirloom mount since you haven't choosen a faction."])
                else
                    C_MountJournal.SummonByID(C['mount']['mountHeirloom'][DB.playerFaction])
                end
            else
                C_MountJournal.SummonByID(tonumber(groundID))
            end
        elseif IsUsableSpell(93326) == true or IsFlyableArea() then
            C_MountJournal.SummonByID(tonumber(flyingID))
        else
            C_MountJournal.SummonByID(tonumber(groundID))
        end
end

function MSE:Initialize()
    self.Initialized = true
end

E:RegisterModule(MSE:GetName())
