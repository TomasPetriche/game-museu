extends KinematicBody2D
class_name PlayerAvatar

var active := true

func _set_active(value):
	active = value
	$PlayerController.active = value
	
func _fade():
	if active:
		self.active = false
		$PlayerController.queue_free()
		$PlayerMovement.queue_free()
		$PlayerAnimation.play("player_fade")
	pass
