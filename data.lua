load()

-- ------------------------------------------------------------------------------------------------
-- ---------- 移除音乐 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

if SIStartup.SISPBGM.remove() then
	local musics = {}
	for name , data in pairs( SIGen.GetList( SITypes.ambientSound ) ) do
		if data.track_type ~= SIFlags.trackType.mainTrack then table.insert( musics , data ) end
	end
	SIGen.ClearList( SITypes.ambientSound ).Extend( musics )
end

-- ------------------------------------------------------------------------------------------------
-- ----------- 初始化 -----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.Init( SISPBGM )

if SIStartup.SISPBGM.enable() then
	for index , musicData in pairs( SISPBGM.musicList ) do
		local file = musicData[2]
		local volume = musicData[3] or 1
		if SIStartup.SISPBGM["music_"..index]() and file then
			SIGen.NewAmbientSound( "music-"..index , SIFlags.trackType.mainTrack , SISPBGM.soundPath..file , volume )
		end
	end
end

SIGen.Finish()