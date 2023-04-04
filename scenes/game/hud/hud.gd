extends CanvasLayer
class_name HUD

export (NodePath) var objective_path : NodePath = ""
var objective_label : Label = null

func _ready():
	for c in get_tree().get_nodes_in_group("ArtefactPickUp"):
		c = c as ArtefactPickUp
		var _err = c.connect("picked_up", self, "_update_hud")
	if objective_path:
		objective_label = get_node_or_null(objective_path)
	_update_hud()
	pass
	

func _update_hud():
	yield(get_tree(), "idle_frame")
	var artefacts_count :int = get_tree().get_nodes_in_group("ArtefactPickUp").size()
	
	if objective_label:
		if artefacts_count !=0:
			objective_label.text = "Colete todos os Artefatos!\nArtefatos Restantes : %d" % [artefacts_count]
		else:
			objective_label.text = "Vá para a próxima sala!"
	pass

func _resume():
	get_tree().call_group("PlayerAvatar", "_set_active", true)
	pass

func _pause():
	get_tree().call_group("PlayerAvatar", "_set_active", false)
	pass
