@tool
extends ScrollContainer
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
const PIN = preload("res://addons/script_spliter/assets/pin.svg")
const FILL_EXPAND = preload("res://addons/script_spliter/assets/fill_expand.svg")
const SPLIT_CPLUS_TOOL = preload("res://addons/script_spliter/assets/split_cplus_tool.svg")
const SPLIT_MINUS_TOOL = preload("res://addons/script_spliter/assets/split_minus_tool.svg")
const SPLIT_PLUS_TOOL = preload("res://addons/script_spliter/assets/split_plus_tool.svg")
const SPLIT_RMINUS_TOOL = preload("res://addons/script_spliter/assets/split_rminus_tool.svg")
const SPLIT_RPLUS_TOOL = preload("res://addons/script_spliter/assets/split_rplus_tool.svg")
const SPLIT_CMINUS_TOOL = preload("res://addons/script_spliter/assets/split_cminus_tool.svg")

const PAD : float = 12.0

var _root : VBoxContainer = null
var _min_size : float = 0.0

@warning_ignore("unused_private_class_variable")
var _pin_root : Control = null

func _ready() -> void:
	_root = VBoxContainer.new()
	_root.alignment = BoxContainer.ALIGNMENT_BEGIN
	_root.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_root.size_flags_vertical = Control.SIZE_EXPAND_FILL
	add_child(_root)
	_setup()
	
	custom_minimum_size.x = _min_size + PAD
	horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	vertical_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_NEVER

func get_root() -> Node:
	return _root
	
func _enter_tree() -> void:
	add_to_group(&"__SCRIPT_SPLITER__IO__")
	
func _exit_tree() -> void:
	remove_from_group(&"__SCRIPT_SPLITER__IO__")

func _setup() -> void:
	make_function(&"EXPAND", FILL_EXPAND, "Expand/Unexpand current tab container.")
	make_function(&"SPLIT_COLUMN", SPLIT_CPLUS_TOOL, "Split to new column.")
	make_function(&"MERGE_COLUMN", SPLIT_CMINUS_TOOL, "Merge current column.")
	make_function(&"SPLIT_ROW", SPLIT_RPLUS_TOOL, "Split to new row.")
	make_function(&"MERGE_ROW", SPLIT_RMINUS_TOOL, "Merge current row.")
	make_function(&"SPLIT_SUB", SPLIT_PLUS_TOOL, "Sub Split current editor.")
	make_function(&"MERGE_SPLIT_SUB", SPLIT_MINUS_TOOL, "Merge sub split of current editor.")
	
func enable(id : StringName, e : bool) -> void:
	for x : Node in _root.get_children():
		if x.name == id:
			x.set(&"disabled", !e)
	
func get_button(id : String) -> Button:
	if _root.has_node(id):
		var node : Node = _root.get_node(id)
		if node is Button:
			return node
	return null
	
func make_function(id : StringName, icon : Texture2D = null, txt : String = "") -> void:
	var btn : Button = Button.new()
	btn.name = id
	
	btn.pressed.connect(_call.bind(id))
	btn.icon = icon
	btn.alignment = HORIZONTAL_ALIGNMENT_CENTER
	btn.tooltip_text = txt
	btn.flat = is_instance_valid(icon)
	_min_size = maxf(icon.get_size().x, _min_size)
	_root.add_child(btn)

func _call(id : StringName) -> void:
	for x : Node in get_tree().get_nodes_in_group(&"__SCRIPT_SPLITER__"):
		if x.has_method(&"_io_call"):
			x.call(&"_io_call", id)
