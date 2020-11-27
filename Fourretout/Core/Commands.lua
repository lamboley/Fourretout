local E, L, V, P, G = unpack(select(2, ...))

function E:LoadCommands()
    self:RegisterChatCommand('frt', 'Config_OpenWindow')
end
