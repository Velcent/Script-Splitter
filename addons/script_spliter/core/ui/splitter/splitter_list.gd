@tool
extends ItemList
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#	Script Spliter
#	https://github.com/CodeNameTwister/Script-Spliter
#
#	Script Spliter addon for godot 4
#	author:		"Twister"
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

var _ss: Callable

func _ready() -> void:
	set_process(false)

func update() -> void:
	set_process(true)

func set_reference(scall : Callable) -> void:
	_ss = scall
	
func _process(__: float) -> void:
	set_process(false)
	if !_ss.is_valid():
		return
	_ss.call()
