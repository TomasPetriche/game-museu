extends Area2D
class_name ArtefactPickUp

signal picked_up

var set_spawn_on_pick : bool = true

export (Resource) var artefact_data 

func _ready():
	var _err = connect("body_entered", self, "_check_pick_up")
	if artefact_data:
		artefact_data = artefact_data as ArtefactData
		$Sprite.texture = artefact_data.sprite_texture
	pass

func _check_pick_up(body:Node):
	if body is KinematicBody2D:
		
		if artefact_data:
		# Call an call_group with a null argument, does not work
			artefact_data = artefact_data as ArtefactData
			get_tree().call_group("ArtefactPopup", "_popup_pick_up", artefact_data.name_info, artefact_data.text_info, artefact_data.icon_texture)
		if set_spawn_on_pick:
			get_tree().call_group("PlayerSpawn", "_set_position", self.global_position)
		yield(get_tree(),"idle_frame")
		emit_signal("picked_up")
		queue_free()
	pass 
