local E = unpack(select(2, ...))
local AR = E:GetModule('AutoRepair')

local CanMerchantRepair, GetGuildInfo, RepairAllItems = CanMerchantRepair, GetGuildInfo, RepairAllItems

function AR.MERCHANT_SHOW()
    if CanMerchantRepair() then
        if select(1, GetGuildInfo('player')) then RepairAllItems(true) end
        RepairAllItems()
    end
end

function AR:Initialize()
    self.Initialized = true

    self:RegisterEvent('MERCHANT_SHOW')
end

E:RegisterModule(AR:GetName())
