local E = unpack(Fourretout)
local Engine, L = unpack(select(2, ...))

local next, pairs, ipairs, gsub = next, pairs, ipairs, gsub
local tostring = tostring

local C_MapGetMapInfo = C_Map.GetMapInfo
local C_MountJournalGetMountIDs, C_MountJournalGetMountInfoByID = C_MountJournal.GetMountIDs, C_MountJournal.GetMountInfoByID

local function UpdateZoneID()
    E.Options.args.miscellaneous.args.mount.args.names = {
        type = 'group',
        name = '',
        inline = true,
        args = {}
    }
    if next(E.db.general.dontFly) then
        for name in pairs(E.db.general.dontFly) do
            E.Options.args.miscellaneous.args.mount.args.names.args[name] = {
                name = name .. ' - ' .. C_MapGetMapInfo(name).name,
                type = 'toggle',
                order = -1,
                get = function() return E.db.general.dontFly[name] end,
                set = function(_, value) E.db.general.dontFly[name] = value end
            }
        end
    end
end

E.Options.args.miscellaneous = {
    type = 'group',
    order = 1,
    name = L['Miscellaneous'],
    childGroups = 'tab',
    get = function(info) return E.db.general[info[#info]] end,
    set = function(info, value) E.db.general[info[#info]] = value end,
    args = {
        mount = {
            type = 'group',
            order = 0,
            name = L['Mount'],
            args = {
                descriptionSelectMount = {
                    type = 'description',
                    order = 0,
                    name = L['Select the ground and flying mount who will be summoned.'],
                },
                selectGroundMount = {
                    name = L["Select ground mount"],
                    type = 'select',
                    order = 1,
                    width = 2,
                    get = function(_) return E.db.mount.groundMount end,
                    set = function(_, value) E.db.mount.groundMount = value end,
                    values = function()
                        local filters = {}
                        for _, id in ipairs(C_MountJournalGetMountIDs()) do
                            local creatureName, _, iconTexture, _, isUsable, _, _, _, _, _, isCollected = C_MountJournalGetMountInfoByID(id)
                            if isCollected and isUsable  then
                                filters[id] = format('|T%s:14:14:::64:64:4:60:4:60|t %s', iconTexture, creatureName)
                            end
                        end
                        return filters
                    end,
                },
                selectFlyingMount = {
                    name = L["Select flying mount"],
                    type = 'select',
                    order = 2,
                    width = 2,
                    get = function(_) return E.db.mount.flyingMount end,
                    set = function(_, value) E.db.mount.flyingMount = value end,
                    values = function()
                        local filters = {}
                        for _, id in ipairs(C_MountJournalGetMountIDs()) do
                            local creatureName, _, iconTexture, _, isUsable, _, _, _, _, _, isCollected = C_MountJournalGetMountInfoByID(id)
                            if isCollected and isUsable then
                                filters[id] = format('|T%s:14:14:::64:64:4:60:4:60|t %s', iconTexture, creatureName)
                            end
                        end
                        return filters
                    end,
                },
                spacer1 = Engine.Spacer(3),
                descriptionAddRemoveManu = {
                    type = 'description',
                    order = 4,
                    name = L['Add or remove manually an entrie from the list of forced ground mount.'],
                },
                addZoneID = {
                    type = 'input',
                    order = 5,
                    name = L['Add a zoneID'],
                    desc = L['Add the zoneID to the forced ground mount list.'],
                    get = function() return '' end,
                    set = function(_, value)
                        if value == '' or gsub(value, '%s+', '') == '' then return; end
                        E.db.general.dontFly[value] = true
                        UpdateZoneID()
                    end,
                },
                removeZoneID = {
                    type = 'input',
                    order = 6,
                    name = L['Remove a zoneID'],
                    desc = L['Remove the zoneID from the forced ground mount list.'],
                    get = function() return '' end,
                    set = function(_, value)
                        if value == '' or gsub(value, '%s+', '') == '' then return; end
                        E.db.general.dontFly[value] = nil
                        UpdateZoneID()
                    end,
                },
                showZoneID = {
                    type = 'execute',
                    order = 7,
                    name = L['Print current zoneID'],
                    func = function() E:ShowZoneID() end
                },
                descriptionAddRemoveAuto = {
                    type = 'description',
                    order = 8,
                    name = L['Add or remove the current regionID from the list of forced ground mount.'],
                },
                addCurrentZoneID = {
                    type = 'execute',
                    order = 9,
                    name = L['Add current zoneID'],
                    desc = L['Add the current zoneID to the forced ground mount list.'],
                    func = function()
                        E.db.general.dontFly[tostring(E.GetZoneID())] = true
                        UpdateZoneID()
                    end
                },
                removeCurrentZoneID = {
                    type = 'execute',
                    order = 10,
                    name = L['Remove current zoneID'],
                    desc = L['Remove the current zoneID from the forced ground mount list.'],
                    func = function()
                        E.db.general.dontFly[tostring(E:GetZoneID())] = nil
                        UpdateZoneID()
                    end
                }
            }
        },
        autoSell = {
            type = 'group',
            order = 1,
            name = 'AutoSell',
            args = {
            }
        }
    }
}

UpdateZoneID()
