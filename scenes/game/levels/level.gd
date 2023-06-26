extends Node2D
class_name Level

export (String) var next_level_id : String

signal all_artefacts_collected

func _ready():
	
	
	var _err = null
	for c in get_tree().get_nodes_in_group("ArtefactPickUp"):
		c = c as ArtefactPickUp
		_err = c.connect("picked_up", self, "_check_progress")
	
	for c in get_tree().get_nodes_in_group("ExitArea"):
		_err = self.connect("all_artefacts_collected", c, "_reveal_icon")
	pass


func _check_progress():
	yield(get_tree(), "idle_frame")
	
	if get_tree().get_nodes_in_group("ArtefactPickUp").size() == 0:
		emit_signal("all_artefacts_collected")
	pass

func _go_to_next_level():
	get_tree().call_group("Main", "go_to_scene", next_level_id)
	pass

func _restart_level():
	get_tree().call_group("Main", "restart_scene")
	pass
