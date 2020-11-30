local E = unpack(select(2, ...))
local AS = E:GetModule('AutoSell')

local GetContainerNumSlots, GetContainerItemID, GetItemInfo, UseContainerItem = GetContainerNumSlots, GetContainerItemID, GetItemInfo, UseContainerItem

function AS.MERCHANT_SHOW()
    for sacID = 0, NUM_BAG_SLOTS do
        for slotID = 1, GetContainerNumSlots(sacID) do
            local itemID = GetContainerItemID(sacID, slotID)
            if itemID then
                local _, _, itemRarity, _, _, _, _, _, _, _, _, itemClassID = GetItemInfo(itemID)
                if itemRarity == 0 or (itemRarity == 1 and (itemClassID == 2 or itemClassID == 4)) then
                    UseContainerItem(sacID, slotID)
                end
            end
        end
    end
end

function AS:Initialize()
    self.Initialized = true

    self:RegisterEvent('MERCHANT_SHOW')
end

E:RegisterModule(AS:GetName())
