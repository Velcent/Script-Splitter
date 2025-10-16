extends VBoxContainer
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
const Editor = preload("res://addons/script_spliter/core/ui/splitter/editor_container.gd")
const CONTAINER = preload("res://addons/script_spliter/core/ui/multi_split_container/taby/container.tscn")

var _editor : Editor = null
var tab : Node = null

func set_update_tab_extension(e : bool) -> void:
	if is_instance_valid(tab):
		tab.set_enable(e)

func _ready() -> void:
	_editor = Editor.new()
	
	#tab = CONTAINER.instantiate()
	#tab.set_ref(_editor.get_tab_bar())
	
	#add_child(tab)
	add_child(_editor)
	#tab.z_index = 2
	
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	set_update_tab_extension(true)
	
func _enter_tree() -> void:
	add_to_group(&"__SP_EC__")
	
func _exit_tree() -> void:
	remove_from_group(&"__SP_EC__")
	
func get_editor() -> Editor:
	return _editor

func update(color : Color) -> void:
	if !is_instance_valid(tab):
		return
	tab.set_select_color(color)
	tab.update()
