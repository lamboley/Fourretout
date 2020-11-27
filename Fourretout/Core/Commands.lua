local E = unpack(select(2, ...))

function E:LoadCommands()
    self:RegisterChatCommand('frt', 'ToggleOptionsUI')
end
