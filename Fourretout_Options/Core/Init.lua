local B, L, C, DB = unpack(Fourretout)

local AceGUI = LibStub("AceGUI-3.0")

local init = CreateFrame("Frame")
init:RegisterEvent("PLAYER_LOGIN")
init:SetScript("OnEvent", function()
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("Example Frame")
    frame:SetStatusText("AceGUI-3.0 Example Container Frame")
end)
