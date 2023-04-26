extends KinematicBody2D
class_name PlayerAvatar

var active := true

func _set_active(value):
	active = value
	$PlayerController.active = value
	
func _fade():
	if active:
		self.active = false
		$PlayerMovement/MoveTween.stop_all()
		$PlayerController.queue_free()
		$PlayerMovement.queue_free()
		yield(get_tree(), "idle_frame")
		$PlayerAnimation.play("player_fade")
	pass
