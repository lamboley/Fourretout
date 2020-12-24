local E = unpack(select(2, ...))
local A = E:GetModule('Alerts')

function A:Initialize()
    self.Initialized = true

    self:AlertsFoodMage()
end

E:RegisterModule(A:GetName())
