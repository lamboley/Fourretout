local E = unpack(select(2, ...))
local B = E:GetModule('Blizzard')

local hooksecurefunc = hooksecurefunc

function B.PLAYER_REGEN_ENABLED()
    GameTooltip:SetScript('OnShow',GameTooltip.Show)
end

function B.PLAYER_REGEN_DISABLED()
    GameTooltip:SetScript('OnShow',GameTooltip.Hide)
    if GameTooltip:IsShown() then GameTooltip:Hide() end
end

function B:HandleDefaultTooltip()
    hooksecurefunc('GameTooltip_SetDefaultAnchor', function(tooltip)
        tooltip:SetOwner(UIParent, 'ANCHOR_BOTTOMRIGHT')
    end)

    self:RegisterEvent('PLAYER_REGEN_ENABLED')
    self:RegisterEvent('PLAYER_REGEN_DISABLED')
end



