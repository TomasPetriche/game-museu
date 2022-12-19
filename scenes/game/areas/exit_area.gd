extends Area2D
class_name ExitArea

signal player_exited_level

func _check_body(body):
	if body is KinematicBody2D:
		emit_signal("player_exited_level")
	pass # Replace with function body.
