extends Area2D
class_name ArtefactPickUp

signal picked_up

func _ready():
	var _err = connect("body_entered", self, "_check_pick_up")

func _check_pick_up(body:Node):
	if body is KinematicBody2D:
		emit_signal("picked_up")
		queue_free()
	pass 
