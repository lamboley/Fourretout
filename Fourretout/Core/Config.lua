local E = unpack(select(2, ...))

function E:Config_IsOpen()
    local ACD = E.Libs.AceConfigDialog
    local ConfigOpen = ACD and ACD.OpenFrames and ACD.OpenFrames[E.name]
    return ConfigOpen and ConfigOpen.frame
end

function E:Config_GetToggleMode()
    if E:Config_IsOpen() then
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

    local ACD = E.Libs.AceConfigDialog
    if ACD then
        ACD[E:Config_GetToggleMode()](ACD, E.name)
    end

end
