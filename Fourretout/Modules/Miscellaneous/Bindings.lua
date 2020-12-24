local E = unpack(select(2, ...))
local B = E:GetModule('Bindings')

local GetMacroIndexByName, CreateMacro, EditMacro, SetBindingMacro = GetMacroIndexByName, CreateMacro, EditMacro, SetBindingMacro

local function CreateBindingMacro(name, texture, action, key)
    local macroIconTexture = texture or 'INV_MISC_QUESTIONMARK'
    if GetMacroIndexByName(name) == 0 then
        CreateMacro(name, macroIconTexture, action, nil)
    else
        EditMacro(name, name, macroIconTexture, action, 1, nil)
    end
    SetBindingMacro(key, name)
end

function B.PLAYER_LOGIN()
    CreateBindingMacro('HEARTHSTONE_TOY', nil, "/use Eternal Traveler's Hearthstone", 'F4')
end

function B:Initialize()
    self.Initialized = true

    self:RegisterEvent('PLAYER_LOGIN')
end

E:RegisterModule(B:GetName())
