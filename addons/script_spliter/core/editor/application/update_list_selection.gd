@tool
extends "res://addons/script_spliter/core/editor/app.gd"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
var _LIST_VISIBLE_SELECTED_COLOR : Color = Color.from_string("7b68ee", Color.CORNFLOWER_BLUE)
var _LIST_VISIBLE_OTHERS_COLOR : Color = Color.from_string("4835bb", Color.DARK_BLUE)


var _script_list_selection : bool = false

func execute(value : Variant = null) -> bool:
	if !value is Array or value.size() < 1:
		return false
		
	if _script_list_selection:
		return true
	
	_script_list_selection = true
	
	
	var _editor_list : ItemList = value[0]
	var _script_list : ItemList = value[1]
		
	var selected : String = ""
	var others_selected : PackedStringArray = []


	var current : TabContainer = _manager.get_base_container().get_current_container()
	
	
	for x : MickeyTool in _tool_db.get_tools():
		if x.is_valid():
			var _root : Node = x.get_root()
			if _root.current_tab == x.get_control().get_index():
				var idx : int = x.get_index()
				if _editor_list.item_count > idx and idx > -1:
					if _root == current:
						selected = _editor_list.get_item_tooltip(idx)
					else:
						others_selected.append(_editor_list.get_item_tooltip(idx))
	var color : Color = _LIST_VISIBLE_SELECTED_COLOR
	var color_ctn : Color = _LIST_VISIBLE_SELECTED_COLOR
	var others : Color = _LIST_VISIBLE_OTHERS_COLOR
	color.a = 0.5
	others.a = 0.5
	color_ctn.a = 0.25
	
	for x : int in _script_list.item_count:
		var mt : String = _script_list.get_item_tooltip(x)
		if selected == mt:
			_script_list.set_item_custom_bg_color(x, color)
			_script_list.set_item_custom_fg_color(x, Color.WHITE)
			_script_list.select(x, true)
		elif others_selected.has(mt):
			_script_list.set_item_custom_bg_color(x, others)
		else:
			_script_list.set_item_custom_bg_color(x, Color.TRANSPARENT)
	_script_list.ensure_current_is_visible()
	set_deferred(&"_script_list_selection", false)
	return false
