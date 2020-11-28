local E = unpack(select(2, ...))
local EL = E:GetModule('EnhanceLoot')

function EL:LOOT_OPENED()
    for i = 1, GetNumLootItems() do
        LootSlot(i)
    end
end

function EL:Initialize()
    self.Initialized = true

    LootFrame:SetAlpha(0)
    self:RegisterEvent('LOOT_OPENED')
end

E:RegisterModule(EL:GetName())
