@tool
extends "res://addons/script_spliter/core/editor/app.gd"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
const BaseContainer = preload("res://addons/script_spliter/core/base/container.gd")


func execute(value : Variant = null) -> bool:
	if value is Array and value.size() == 3:
		var from : Container = value[0]
		var index : int = value[1]
		var to : Container = value[2]
		
		if from == to:
			return false
		
		if from is BaseContainer.SplitterContainer.SplitterEditorContainer.Editor and to is BaseContainer.SplitterContainer.SplitterEditorContainer.Editor:
			for x : MickeyTool in _tool_db.get_tools():
				if x.is_valid():
					if x.get_root() == from and x.get_control().get_index() == index:
						x.ochorus(to)
						_manager.clear_editors()
						return true
	return false
