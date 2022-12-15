extends Node2D
class_name Level

export (String) var next_level_id : String

func _check_progress():
	pass

func _go_to_next_level():
	get_tree().call_group("Main", "go_to_scene", next_level_id)
	pass

func _restart_level():
	get_tree().call_group("Main", "restart_scene")
	pass
