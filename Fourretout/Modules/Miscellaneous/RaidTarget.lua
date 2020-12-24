local E = unpack(select(2, ...))
local RT = E:GetModule('RaidTarget')

local select = select

local IsInInstance, GetRaidTargetIndex, SetRaidTarget = IsInInstance, GetRaidTargetIndex, SetRaidTarget
local GetSpecialization, GetSpecializationInfo = GetSpecialization, GetSpecializationInfo

function RT:PLAYER_ENTERING_WORLD()
    self:SetRaidTargetHealer()
end

function RT:GROUP_LEFT()
    self:SetRaidTargetHealer()
end

function RT:RAID_TARGET_UPDATE()
    self:SetRaidTargetHealer()
end

function RT:PLAYER_LOGIN()
    self:SetRaidTargetHealer()
end

function RT.SetRaidTargetHealer()
    local instanceType = select(2, IsInInstance())
    if instanceType and instanceType ~= 'none' then
        if select(5, GetSpecializationInfo(GetSpecialization())) == 'HEALER' then
            if GetRaidTargetIndex('player') == nil then SetRaidTarget('player', 4) end
        end
    else
        SetRaidTarget('player', 0)
    end
end

function RT:Initialize()
    self.Initialized = true

    self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:RegisterEvent('PLAYER_LOGIN')
    self:RegisterEvent('GROUP_LEFT')
    self:RegisterEvent('RAID_TARGET_UPDATE')
end

E:RegisterModule(RT:GetName())
