local E, L, V, P, G = unpack(select(2, ...))

function E:Config_CloseWindow()
    local ACD = E.Libs.AceConfigDialog
    if ACD then
        ACD:Close('Fourretout')
    end
end

function E:Config_OpenWindow()
    local ACD = E.Libs.AceConfigDialog
    if ACD then
        ACD:Open('Fourretout')
    end
end
