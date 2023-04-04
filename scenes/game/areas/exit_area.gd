extends Area2D
class_name ExitArea

signal player_exited_level


func _ready():
	$Sprite.hide()
	pass

func _check_body(body):
	if body is PlayerAvatar:
		body._fade()
		get_tree().call_group("ExitArea", "hide")
		yield(get_tree().create_timer(.75), "timeout")
		emit_signal("player_exited_level")
	pass 

func _reveal_icon():
	$Sprite.show()
	$Sprite/ArtefactTween._go_up()
	pass
