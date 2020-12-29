local data =
{
	name = "sispbgm" ,
	settings =
	{
		remove = { "bool" , "startup" , false } ,
		enable = { "bool" , "startup" , true , nil , nil , nil , nil , nil , nil , nil }
	} ,
	
	musicList = need( "MusicList" )
}

local musicList = {}
for index , musicData in pairs( data.musicList ) do
	if musicData[1] then table.insert( musicList , musicData ) end
end
data.musicList = musicList

for index , musicData in pairs( data.musicList ) do
	data.settings["music_"..index] = { "bool" , "startup" , true , nil , nil , nil , nil , nil , { "SISPBGM.music-name" , musicData[1] } , { "SISPBGM.music-description" , musicData[1] , musicData[2] or { "SISPBGM.music-nil" } } }
end
data.settings.enable[10] = { "SISPBGM.music-enable-count" , #data.musicList-1 }

return data