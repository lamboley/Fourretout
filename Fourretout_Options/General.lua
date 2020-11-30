local E = unpack(Fourretout)
local _, L = unpack(select(2, ...))

E.Options.args.general = {
    type = 'group',
    order = 0,
    name = L['General'],
    childGroups = 'tab',
    get = function(info) return E.db.general[info[#info]] end,
    set = function(info, value) E.db.general[info[#info]] = value end,
    args = {
    }
}
