@tool
extends RefCounted
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

const MickeyTool = preload("res://addons/script_spliter/core/editor/tools/magic/mickey_tool.gd")
const MickeyToolRoute = preload("res://addons/script_spliter/core/editor/tools/magic/mickey_tool_route.gd")

func build(control : Node) -> MickeyTool:
	return _build_tool(control)

func _build_tool(_control : Node) -> MickeyTool:
	return null
