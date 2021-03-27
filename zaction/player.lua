-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIMusicPlayer =
{
	interfaceId = "sispbgm-player" ,
	toolbarButtonId = "SISPBGMPlayerToolbarButton" ,
	toolbarButtonName = "sispbgm-player-toolbar-button" ,
	
	itemName = "sispbgm-item-icon-music" ,
	
	settingsDefaultData =
	{
		view = nil
	}
}

SIGlobal.Create( "musicplayer" )

-- ------------------------------------------------------------------------------------------------
-- ---------- 窗口方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIMusicPlayer.OpenView( playerIndex )
	local player = game.players[playerIndex]
	local settings = SIMusicPlayer.GetSettings( playerIndex )
	if settings.view then SIMusicPlayer.CloseView( playerIndex )
	else
		local view = player.gui.left.add{ type = "frame" , name = "sispbgm-view" , caption = { "SISPBGM.view-title" } , direction = "vertical" , style = "sispbgm-view" }
		
		settings.view = view
	end
end

function SIMusicPlayer.CloseView( playerIndex )
	local settings = SIMusicPlayer.GetSettings( playerIndex )
	if settings then
		if settings.view then
			settings.view.destroy()
			settings.view = nil
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 功能方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIMusicPlayer.ShowViewByPlayerIndex( playerIndex )
	SIMusicPlayer.OpenView( playerIndex )
end

function SIMusicPlayer.HideViewByPlayerIndex( playerIndex )
	SIMusicPlayer.CloseView( playerIndex )
end

function SIMusicPlayer.ShowViews()
	for playerIndex , settings in pairs( musicplayer ) do SIMusicPlayer.OpenView( playerIndex ) end
end

function SIMusicPlayer.HideViews()
	for playerIndex , settings in pairs( musicplayer ) do SIMusicPlayer.CloseView( playerIndex ) end
end

function SIMusicPlayer.GetSettings( playerIndex )
	local settings = musicplayer[playerIndex]
	if not settings then
		settings = table.deepcopy( SIMusicPlayer.settingsDefaultData )
		musicplayer[playerIndex] = settings
	end
	return settings
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIMusicPlayer.OnInit()
	remote.call( "sicfl-toolbar" , "AddTool" , SIMusicPlayer.toolbarButtonId , SIMusicPlayer.toolbarButtonName , SIMusicPlayer.itemName , "SISPBGM.toolbar-button" , "SISPBGM.toolbar-tooltip" , SIMusicPlayer.interfaceId , "ShowViewByPlayerIndex" )
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Init( SIMusicPlayer.OnInit )

remote.add_interface( SIMusicPlayer.interfaceId ,
{
	ShowViewByPlayerIndex = SIMusicPlayer.ShowViewByPlayerIndex ,
	HideViewByPlayerIndex = SIMusicPlayer.HideViewByPlayerIndex ,
	ShowViews = SIMusicPlayer.ShowViews ,
	HideViews = SIMusicPlayer.HideViews
} )