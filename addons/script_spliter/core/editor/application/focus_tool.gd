@tool
extends "res://addons/script_spliter/core/editor/app.gd"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
const BaseList = preload("res://addons/script_spliter/core/base/list.gd")

func execute(value : Variant = null) -> bool:
	if value is ScriptEditorBase:
		var control : Control = value.get_base_editor()
		for x : MickeyTool in _tool_db.get_tools():
			if x.has(control):
				value = x
				break
	if value is MickeyTool:
		var index : int = value.get_index()
		var editor_list : BaseList = _manager.get_editor_list()
		if editor_list.item_count() > index and index > -1:
			var control : Node = value.get_control()
			var root : Node = value.get_root()
			if root is TabContainer:
				var base : Manager.BaseContainer = _manager.get_base_container()
				var _index : int = control.get_index()
				if root.current_tab != _index and  _index > -1 and _index < root.get_tab_count():
					if root.has_method(&"set_tab"):
						root.call(&"set_tab", _index)
					else:
						root.set(&"current_tab", _index)
					
				var container : Control = base.get_current_container()
				if is_instance_valid(container):
					container.modulate = Color.DARK_GRAY
				
				base.set_current_container(root)
	
				if is_instance_valid(root):
					root.modulate = Color.WHITE
					
				var new_container : Node = base.get_container(root)
				if is_instance_valid(new_container) and new_container.has_method(&"expand_splited_container"):
					new_container.call(&"expand_splited_container", base.get_container_item(root))
				
				if is_instance_valid(container):
					container = base.get_container(container)
					if is_instance_valid(container) and container != new_container and container.has_method(&"expand_splited_container"):
						container.call(&"expand_splited_container", null)
				
				var grant_conainer : Node = base.get_editor_root_container(new_container)
				if is_instance_valid(grant_conainer):
					var parent : Node = grant_conainer.get_parent()
					if is_instance_valid(parent) and parent.has_method(&"expand_splited_container"):
						parent.call(&"expand_splited_container", base.get_editor_root_container(new_container))
					
			if !editor_list.is_selected(index):
				editor_list.select(index)
				
			_manager.io.update()
	return false
