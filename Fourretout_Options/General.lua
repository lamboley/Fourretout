local E, _, P, G = unpack(Fourretout)
local C, L = unpack(select(2, ...))

E.Options.args.general = {
    type = 'group',
    order = 1,
    name = L['General'],
    childGroups = 'tab',
    get = function(info) return E.db.general[info[#info]] end,
    set = function(info, value) E.db.general[info[#info]] = value end,
    args = {
        mount = {
            type  = 'group',
            order = 6,
            name  = L['Mount'],
            args  = {
                mapCantFly = {
                    type  = 'input',
                    order = 7,
                    name  = L['Zone ground mount'],
                    desc = L['List of zoneID where the ground mount will be forced.'],
                    multiline = true,
                    width = 2
                }
            }
        }
    }
}
