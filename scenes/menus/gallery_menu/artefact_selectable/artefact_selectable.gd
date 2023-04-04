extends Area2D
class_name ArtefactSelectable


signal selection_changed

export (Resource) var artefact_data 

var selection_modulate : Color = Color.white
var unselection_modulate : Color = Color(0.35, 0.35, 0.35)

var selected : bool = false

func _ready():
	if artefact_data:
		artefact_data = artefact_data as ArtefactData
		$Sprite.texture = artefact_data.icon_texture
	_set_selection_display(selected)
	pass

func _clicked():
	selected = not selected
	_set_selection_display(selected)
	emit_signal("selection_changed")
	pass

func _set_selection_display(selection : bool):
	if selection:
		$Sprite.self_modulate = selection_modulate
	else:
		$Sprite.self_modulate = unselection_modulate
	pass


func _on_ArtefactSelectable_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		event = event as InputEventMouseButton
		if event.is_pressed() and not event.is_echo():
			_clicked()
	pass
