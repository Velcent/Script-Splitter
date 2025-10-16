@tool
extends EditorPlugin
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


const InputTool = preload("res://addons/script_spliter/core/Input.gd")
const TWISTER_SCRIPT_SPLITER = preload("res://addons/script_spliter/core/builder.gd")
var builder : TWISTER_SCRIPT_SPLITER = null
var handler : InputTool = null
		
var tab_container : Node = null:
	get:
		if !is_instance_valid(tab_container):
			var script_editor: ScriptEditor = EditorInterface.get_script_editor()
			tab_container = find(script_editor, "*", "TabContainer")
		return tab_container
var item_list : Node = null:
	get:
		if !is_instance_valid(item_list):
			var script_editor: ScriptEditor = EditorInterface.get_script_editor()
			item_list = find(script_editor, "*", "ItemList")
		return item_list
		
func find(root : Node, pattern : String, type : String) -> Node:
	var e : Array[Node] = root.find_children(pattern, type, true, false)
	if e.size() > 0:
		return e[0]
	return null

func _enter_tree() -> void:
	add_to_group(&"__SCRIPT_SPLITER__")
	builder = TWISTER_SCRIPT_SPLITER.new()
	handler = InputTool.new(self, builder)
	
	
func _ready() -> void:
	set_process(false)
	set_process_input(false)
	for __ : int in range(5):
		await Engine.get_main_loop().process_frame
	if is_instance_valid(builder):
		builder.init_1(self, tab_container, item_list)
	if is_instance_valid(handler):
		handler.init_1()
	
	builder.connect_callbacks(
		handler.add_column, 
		handler.add_row, 
		handler.remove_column, 
		handler.remove_row,
		handler.left_tab_close,
		handler.right_tab_close,
		handler.others_tab_close
		)
	
func _save_external_data() -> void:
	builder.refresh_warnings()

func _exit_tree() -> void:
	remove_from_group(&"__SCRIPT_SPLITER__")
	for x : Variant in [handler, builder]:
		if is_instance_valid(x) and x is Object:
			x.call(&"init_0")
	
func _process(delta: float) -> void:
	builder.update(delta)
	
func _input(event: InputEvent) -> void:
	if handler.event(event):
		get_viewport().set_input_as_handled()

func _io_call(id : StringName) -> void:
	builder.handle(id)
