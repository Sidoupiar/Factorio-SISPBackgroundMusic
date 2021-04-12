-- ------------------------------------------------------------------------------------------------
-- ---------- 基础数据 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIMusicPlayer =
{
	interfaceId = "sispbgm-player" ,
	toolbarButtonId = "SISPBGMPlayerToolbarButton" ,
	toolbarButtonName = "sispbgm-player-toolbar-button" ,
	
	itemName = "sispbgm-item-icon-music" ,
	playButtonItem = "item/sispbgm-item-icon-next" ,
	iconName = "sispbgm-view-play-" ,
	
	settingsDefaultData =
	{
		search = "" ,
		
		view = nil ,
		textfield = nil ,
		list = nil
	}
}

SIMusicPlayer.iconPosition = #SIMusicPlayer.iconName + 1

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
		
		local flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "label" , caption = { "SISPBGM.view-description" } , style = "sispbgm-view-label-text" }
		
		view.add{ type = "line" , direction = "horizontal" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		settings.textfield = flow.add{ type = "textfield" , text = settings.search , tooltip = { "SISPBGM.view-search-text" } , style = "sispbgm-view-textfield" }
		flow.add{ type = "button" , name = "sispbgm-view-search" , caption = { "SISPBGM.view-search" } , style = "sispbgm-view-button-gray" }
		flow.add{ type = "button" , name = "sispbgm-view-clear" , caption = { "SISPBGM.view-clear" } , style = "sispbgm-view-button-red" }
		settings.list = view.add{ type = "scroll-pane" , horizontal_scroll_policy = "never" , vertical_scroll_policy = "auto-and-reserve-space" }.add{ type = "table" , column_count = 3 , style = "sispbgm-view-list" }
		SIMusicPlayer.FreshList( settings )
		
		view.add{ type = "line" , direction = "horizontal" }
		flow = view.add{ type = "flow" , direction = "horizontal" }
		flow.add{ type = "button" , name = "sispbgm-view-close" , caption = { "SISPBGM.view-close" } , style = "sispbgm-view-button-red" }
		
		settings.view = view
	end
end

function SIMusicPlayer.CloseView( playerIndex )
	local settings = SIMusicPlayer.GetSettings( playerIndex )
	if settings then
		if settings.view then
			settings.view.destroy()
			settings.view = nil
			settings.textfield = nil
			settings.list = nil
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

function SIMusicPlayer.FreshList( settings )
	if settings.list then
		local list = settings.list
		list.clear()
		list.add{ type = "label" , caption = { "SISPBGM.view-label-number" } , style = "sispbgm-view-list-title-icon" }
		list.add{ type = "label" , caption = { "SISPBGM.view-label-name" } , style = "sispbgm-view-list-title-long" }
		list.add{ type = "label" , caption = { "SISPBGM.view-label-option" } , style = "sispbgm-view-list-title-icon" }
		local count = 0
		if not settings.search or settings.search == "" then
			for i , v in pairs( SISPBGM.musicList ) do
				list.add{ type = "label" , caption = { "SISPBGM.view-music-number" , i } , style = "sispbgm-view-list-line-icon" }
				list.add{ type = "label" , caption = { "SISPBGM.view-music-name" , v[1] } , tooltip = { "SISPBGM.view-music-name" , v[1] } , style = "sispbgm-view-list-line-long" }
				list.add{ type = "sprite-button" , name = "sispbgm-view-play-"..i , sprite = SIMusicPlayer.playButtonItem , style = "sispbgm-view-list-line-button" }
				count = count + 1
			end
		else
			for i , v in pairs( SISPBGM.musicList ) do
				if v[1]:find( settings.search ) then
					list.add{ type = "label" , caption = { "SISPBGM.view-music-number" , i } , style = "sispbgm-view-list-line-icon" }
					list.add{ type = "label" , caption = { "SISPBGM.view-music-name" , v[1] } , tooltip = { "SISPBGM.view-music-name" , v[1] } , style = "sispbgm-view-list-line-long" }
					list.add{ type = "sprite-button" , name = "sispbgm-view-play-"..i , sprite = SIMusicPlayer.playButtonItem , style = "sispbgm-view-list-line-button" }
					count = count + 1
				end
			end
		end
		if count < 1 then
			list.add{ type = "label" , caption = { "SISPBGM.view-music-number" , 1 } , style = "sispbgm-view-list-line-icon" }
			list.add{ type = "label" , caption = { "SISPBGM.view-music-none" } , style = "sispbgm-view-list-line-long" }
			list.add{ type = "sprite-button" , sprite = "item/sicfl-item-icon-empty" , style = "sispbgm-view-list-line-button" }
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 公用方法 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

function SIMusicPlayer.OnInit()
	remote.call( "sicfl-toolbar" , "AddTool" , SIMusicPlayer.toolbarButtonId , SIMusicPlayer.toolbarButtonName , SIMusicPlayer.itemName , "SISPBGM.toolbar-button" , "SISPBGM.toolbar-tooltip" , SIMusicPlayer.interfaceId , "ShowViewByPlayerIndex" )
end

function SIMusicPlayer.OnClickView( event )
	local element = event.element
	if element.valid then
		local name = element.name
		if name == "sispbgm-view-search" then
			local settings = SIMusicPlayer.GetSettings( event.player_index )
			settings.search = settings.textfield.text
			SIMusicPlayer.FreshList( settings )
		elseif name == "sispbgm-view-clear" then
			local settings = SIMusicPlayer.GetSettings( event.player_index )
			settings.search = ""
			settings.textfield.text = ""
			SIMusicPlayer.FreshList( settings )
		elseif name == "sispbgm-view-close" then SIMusicPlayer.CloseView( event.player_index )
		elseif name:StartsWith( SIMusicPlayer.iconName ) then
			local player = game.get_player( event.player_index )
			local index = tonumber( name:sub( SIMusicPlayer.iconPosition ) )
			local path = "ambient/sispbgm-music-" .. index
			if game.is_valid_sound_path( path ) then player.play_sound{ path = path }
			else alert( player , { "SISPBGM.cannot-player-music" , SISPBGM.musicList[index][1] } ) end
		end
	end
end

-- ------------------------------------------------------------------------------------------------
-- ---------- 事件注册 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIEventBus
.Init( SIMusicPlayer.OnInit )

.Add( SIEvents.on_gui_click , SIMusicPlayer.OnClickView )

remote.add_interface( SIMusicPlayer.interfaceId ,
{
	ShowViewByPlayerIndex = SIMusicPlayer.ShowViewByPlayerIndex ,
	HideViewByPlayerIndex = SIMusicPlayer.HideViewByPlayerIndex ,
	ShowViews = SIMusicPlayer.ShowViews ,
	HideViews = SIMusicPlayer.HideViews
} )