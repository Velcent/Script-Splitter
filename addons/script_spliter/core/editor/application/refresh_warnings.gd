@tool
extends "res://addons/script_spliter/core/editor/app.gd"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

func execute(_value : Variant = null) -> bool:
	var sp : Array[Node] = Engine.get_main_loop().get_nodes_in_group(&"__SC_SPLITTER__")
	var current : Control = _manager.get_base_container().get_current_container()
	
	var ctool : MickeyTool = null
	var ltool : MickeyTool = null
	
	if sp.size() < 2:
		return true
	
	for x : Variant in _tool_db.get_tools():
		if is_instance_valid(x):
			if x.is_valid():
				var i : int = sp.find(x.get_root())
				var container : Node = sp[i]
				if container is TabContainer:
					var indx : int = x.get_control().get_index()
					if container.current_tab == indx:
						if container == current:
							ctool = x
						ltool = x
						_manager.select_editor_by_index(x.get_index())
					
						
	if is_instance_valid(ctool) and ctool != ltool:
		_manager.select_editor_by_index(ctool.get_index())
		
	return true
