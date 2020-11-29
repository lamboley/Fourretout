local E = unpack(Fourretout)
local _, L = unpack(select(2, ...))

E.Options.args.profile = E.Libs.AceDBOptions:GetOptionsTable(E.data)
E.Options.args.profile.name = L['Profile']
E.Libs.AceConfig:RegisterOptionsTable('FourretoutProfiles', E.Options.args.profile)
E.Libs.DualSpec:EnhanceOptions(E.Options.args.profile, E.data)
