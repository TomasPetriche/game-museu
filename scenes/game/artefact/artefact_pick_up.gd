extends Area2D
class_name ArtefactPickUp

signal picked_up

export (Resource) var artefact_data 

func _ready():
	var _err = connect("body_entered", self, "_check_pick_up")
	if artefact_data:
		artefact_data = artefact_data as ArtefactData
		$Sprite.texture = artefact_data.sprite_texture
	pass

func _check_pick_up(body:Node):
	if body is KinematicBody2D:
		emit_signal("picked_up")
		if artefact_data:
		# Call an call_group with a null argument, does not work
			artefact_data = artefact_data as ArtefactData
			get_tree().call_group("ArtefactPopup", "_popup_pick_up", artefact_data.name_info, artefact_data.text_info, artefact_data.icon_texture)
		yield(get_tree(),"idle_frame")
		queue_free()
	pass 
