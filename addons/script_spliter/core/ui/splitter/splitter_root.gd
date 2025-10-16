@tool
extends "res://addons/script_spliter/core/ui/multi_split_container/multi_split_container.gd"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
const EXPAND = preload("res://addons/script_spliter/assets/expand.svg")

var __setup : bool = false

func _enter_tree() -> void:
	add_to_group(&"__ST_CS__")
	super()
	
	if __setup:
		return
		
	__setup = true
	
	_setup()
	
func _exit_tree() -> void:
	remove_from_group(&"__ST_CS__")

func _setup() -> void:
	drag_button_icon = EXPAND
	drag_button_size = 32.0
	
	
	
