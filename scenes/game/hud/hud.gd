extends CanvasLayer
class_name HUD



func _ready():
	for c in get_tree().get_nodes_in_group("ArtefactPickUp"):
		c = c as ArtefactPickUp
		var _err = c.connect("picked_up", self, "_update_hud")
	_update_hud()
	pass
	

func _update_hud():
	yield(get_tree(), "idle_frame")
	var artefacts_count :int = get_tree().get_nodes_in_group("ArtefactPickUp").size()
	
	if artefacts_count !=0:
		$AllGameElements/ObjectiveContainer/ObjectiveLabel.text = "Colete todos os Artefatos!\nArtefatos Restantes : %d" % [artefacts_count]
	else:
		$AllGameElements/ObjectiveContainer/ObjectiveLabel.text = "Vá para a próxima sala!"
	pass

func _resume():
	get_tree().call_group("PlayerAvatar", "_set_active", true)
	pass

func _pause():
	get_tree().call_group("PlayerAvatar", "_set_active", false)
	pass
