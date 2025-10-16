@tool
extends "res://addons/script_spliter/core/editor/app.gd"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

func execute(value : Variant = null) -> bool:
	if value is int:
		if value < 0:
			return false
			
		for x : MickeyTool in _tool_db.get_tools():
			if x.get_index() == value:
				var root : Variant = x.get_root()
				if is_instance_valid(root):
					if root is TabContainer:
						var index : int = x.get_control().get_index()
						if root.current_tab != index and index > -1 and root.get_tab_count() > index:
							if root.has_method(&"set_tab"):
								root.call(&"set_tab", index)
							else:
								root.current_tab = index
							return true
	return false
