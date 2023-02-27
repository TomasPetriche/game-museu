extends Area2D
class_name ExitArea

signal player_exited_level

func _check_body(body):
	if body is PlayerAvatar:
		body._fade()
		yield(get_tree().create_timer(.75), "timeout")
		emit_signal("player_exited_level")
	pass # Replace with function body.
