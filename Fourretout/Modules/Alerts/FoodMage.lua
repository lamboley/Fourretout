local E = unpack(select(2, ...))
local A = E:GetModule('Alerts')

local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local IsInGroup, GetSpellLink = IsInGroup, GetSpellLink
local SendChatMessage = SendChatMessage

local foodSpellID = {
    [190336] = true
}
function A:LoadEventIfInGroup()
    if IsInGroup() then
        self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
    else
        self:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
    end
end

function A:PLAYER_ENTERING_WORLD()
    self:LoadEventIfInGroup()
end

function A:GROUP_JOINED()
    self:LoadEventIfInGroup()
end

function A:GROUP_LEFT()
    self:LoadEventIfInGroup()
end

function A.COMBAT_LOG_EVENT_UNFILTERED()
    local _, subEvent, _, _, sourceName, _, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()
    if subEvent == 'SPELL_CAST_SUCCESS' then
        if sourceName and sourceName == E.myName then
            if foodSpellID[spellID] then
                SendChatMessage('I just created a table (' .. GetSpellLink(spellID) .. ').')
            end
        end
    end
end

function A:AlertsFoodMage()
    self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:RegisterEvent('GROUP_JOINED')
    self:RegisterEvent('GROUP_LEFT')
end
