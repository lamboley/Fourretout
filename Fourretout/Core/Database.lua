local _, _, _, DB = unpack(select(2, ...))

DB.tocversion = select(4, GetBuildInfo())
