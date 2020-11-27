local E, L, P, G = unpack(select(2, ...))
local B = E:GetModule('Blizzard')

function B:Initialize()
    self.Initialized = true

    B:UpdateObjectiveTrackerFrame()
end

E:RegisterModule(B:GetName())
