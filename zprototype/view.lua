-- ------------------------------------------------------------------------------------------------
-- ---------- 创建物品 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen
.NewGroup( "others" )
.NewSubGroup( "icon-things" )
.NewItem( "icon-music" , 1000 ).AddFlags( SIFlags.itemFlags.hidden )
.NewItem( "icon-next" , 1000 ).AddFlags( SIFlags.itemFlags.hidden )

-- ------------------------------------------------------------------------------------------------
-- ---------- 创建界面 ----------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------

SIGen.NewStyle( "view" ,
{
	type = "frame_style" ,
	parent = "frame" ,
	
	minimal_width = 100 ,
	minimal_height = 100 ,
	maximal_height = 400
} )
.NewStyle( "view-list" ,
{
	type = "table_style" ,
	
	cell_spacing = 2 ,
	horizontal_spacing = 1 ,
	vertical_spacing = 1
} )
.NewStyle( "view-label-text" ,
{
	type = "label_style" ,
	
	width = 420 ,
	
	horizontal_align = "left"
} )
.NewStyle( "view-textfield" ,
{
	type = "textbox_style" ,
	
	width = 200
} )
.NewStyle( "view-list-title-icon" ,
{
	type = "label_style" ,
	
	width = 32 ,
	
	horizontal_align = "center"
} )
.NewStyle( "view-list-title-long" ,
{
	type = "label_style" ,
	
	width = 344 ,
	
	horizontal_align = "center"
} )
.NewStyle( "view-list-line-icon" ,
{
	autoParent = true ,
	
	type = "label_style" ,
	parent = "view-list-title-icon"
} )
.NewStyle( "view-list-line-long" ,
{
	autoParent = true ,
	
	type = "label_style" ,
	parent = "view-list-title-long" ,
	
	horizontal_align = "left"
} )
.NewStyle( "view-list-line-button" ,
{
	type = "button_style" ,
	parent = "button" ,
	
	top_padding = 0 ,
	right_padding = 0 ,
	bottom_padding = 0 ,
	left_padding = 0 ,
	
	minimal_width = 32 ,
	minimal_height = 32
} )
.NewStyle( "view-button-gray" , SIStyles.ColorButton( 0 , SIStyles.grayDirt ) )
.NewStyle( "view-button-red" , SIStyles.ColorButton( 136 , SIStyles.redDirt ) )