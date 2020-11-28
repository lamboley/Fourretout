local E = unpack(select(2, ...))
local M = E:GetModule('Miscellaneous')

local uselessAddon = {
    'Grid2LDB',
    'Grid2RaidDebuffs',
    'Grid2RaidDebuffsOptions',
    'Kui_Media',
    'WeakAurasArchive',
    'WeakAurasCompanion',
    'WeakAurasModelPaths',
    'WeakAurasTemplates',
    'Details_EncounterDetails',
    'Details_RaidCheck',
    'Details_Streamer',
    'Details_TinyThreat',
    'Details_Vanguard',
}

function M:DisableUselessAddons()
    for _, addon in pairs(uselessAddon) do
        DisableAddOn(addon)
    end
end

function M:Initialize()
    self.Initialized = true

    M:DisableUselessAddons()
end

E:RegisterModule(M:GetName())
