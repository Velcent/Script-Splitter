@tool
extends HBoxContainer
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

func _enter_tree() -> void:
	add_to_group(&"__SP_PIN_ROOT__")
	
func _exit_tree() -> void:
	remove_from_group(&"__SP_PIN_ROOT__")
