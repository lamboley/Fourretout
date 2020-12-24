local E = unpack(select(2, ...))
local B = E:GetModule('Blizzard')

function B:Initialize()
    self.Initialized = true

    self:UpdateObjectiveTrackerFrame()
    self:HandleDefaultTooltip()
end

E:RegisterModule(B:GetName())
