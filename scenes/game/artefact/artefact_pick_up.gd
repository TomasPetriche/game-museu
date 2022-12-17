extends Area2D
class_name ArtefactPickUp

signal picked_up

export (String) var name_info : String = "NAME_TEST"
export (String) var text_info : String = "TEXT_DESCRIPTION"
export (Texture) var icon_texture : Texture = null

func _ready():
	var _err = connect("body_entered", self, "_check_pick_up")

func _check_pick_up(body:Node):
	if body is KinematicBody2D:
		emit_signal("picked_up")
		# Call an call_group with a null argument, does not work
		get_tree().call_group("ArtefactPopup", "_popup_pick_up", name_info, text_info, icon_texture)
		yield(get_tree(),"idle_frame")
		queue_free()
	pass 
