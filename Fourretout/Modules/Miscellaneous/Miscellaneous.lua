local E, L, V, P, G = unpack(select(2, ...))
local M = E:GetModule('Miscellaneous')

function M:Initialize()
    self.Initialized = true
end

E:RegisterModule(M:GetName())
