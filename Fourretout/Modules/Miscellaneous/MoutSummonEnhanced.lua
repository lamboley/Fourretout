local E, L, V, P, G = unpack(select(2, ...))
local MSE = E:GetModule('MoutSummonEnhanced')

function MSE:Initialize()
    self.Initialized = true
    --self:LoadRaidMarker()
    --self:LoadLootRoll()
    --self:LoadChatBubbles()
    --self:LoadLoot()
    --self:ToggleItemLevelInfo(true)
    --self:RegisterEvent('MERCHANT_SHOW')
    --self:RegisterEvent('RESURRECT_REQUEST')
    --self:RegisterEvent('PLAYER_REGEN_DISABLED', 'ErrorFrameToggle')
    --self:RegisterEvent('PLAYER_REGEN_ENABLED', 'ErrorFrameToggle')
    --self:RegisterEvent('CHAT_MSG_BG_SYSTEM_HORDE', 'PVPMessageEnhancement')
    --self:RegisterEvent('CHAT_MSG_BG_SYSTEM_ALLIANCE', 'PVPMessageEnhancement')
    --self:RegisterEvent('CHAT_MSG_BG_SYSTEM_NEUTRAL', 'PVPMessageEnhancement')
    --self:RegisterEvent('PARTY_INVITE_REQUEST', 'AutoInvite')
    --self:RegisterEvent('GROUP_ROSTER_UPDATE', 'AutoInvite')
    --self:RegisterEvent('CVAR_UPDATE', 'ForceCVars')
    --self:RegisterEvent('COMBAT_TEXT_UPDATE')
    --self:RegisterEvent('PLAYER_ENTERING_WORLD')
    --self:RegisterEvent('QUEST_COMPLETE')

    print('in Mount')
end

E:RegisterModule(MSE:GetName())
