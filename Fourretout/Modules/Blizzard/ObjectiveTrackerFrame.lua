local E, L, P, G = unpack(select(2, ...))
local B = E:GetModule('Blizzard')

function B:PLAYER_ENTERING_WORLD()
    local instanceType = select(2, IsInInstance())
    if not instanceType then return end

    if instanceType == 'pvp' or instanceType == 'arena' then
        ObjectiveTrackerFrame:Hide()
    elseif instanceType == 'party' or instanceType == 'raid' or instanceType == 'scenario' then
        ObjectiveTrackerFrame:Show()
        ObjectiveTracker_Collapse()
    else
        ObjectiveTrackerFrame:Show()
        ObjectiveTracker_Expand()
    end
end

function B:UpdateObjectiveTrackerFrame()
    ObjectiveTrackerFrame:SetScale(0.85)

    self:RegisterEvent('PLAYER_ENTERING_WORLD')
end



