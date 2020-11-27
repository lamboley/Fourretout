local E, L, P, G = unpack(select(2, ...))
local MSE = E:GetModule('MoutSummonEnhanced')

function MSE:Initialize()
    self.Initialized = true
end

E:RegisterModule(MSE:GetName())
