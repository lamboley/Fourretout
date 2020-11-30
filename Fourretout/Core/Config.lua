local E = unpack(select(2, ...))

local select = select

local InCombatLockdown, IsAddOnLoaded, GetAddOnInfo, EnableAddOn, LoadAddOn = InCombatLockdown, IsAddOnLoaded, GetAddOnInfo, EnableAddOn, LoadAddOn

function E:Config_IsOpen()
    local ACD = self.Libs.AceConfigDialog
    local ConfigOpen = ACD and ACD.OpenFrames and ACD.OpenFrames[self.name]
    return ConfigOpen and ConfigOpen.frame
end

function E:Config_GetToggleMode()
    if self:Config_IsOpen() then
        return 'Close'
    else
        return 'Open'
    end
end

function E:ToggleOptionsUI()
    if InCombatLockdown() then return end

    if not IsAddOnLoaded('Fourretout_Options') then
        if select(5, GetAddOnInfo('Fourretout_Options')) ~= 'MISSING' then
            EnableAddOn('Fourretout_Options')
            LoadAddOn('Fourretout_Options')
        end
    end

    local ACD = self.Libs.AceConfigDialog
    if ACD then
        ACD[self:Config_GetToggleMode()](ACD, self.name)
    end

end
