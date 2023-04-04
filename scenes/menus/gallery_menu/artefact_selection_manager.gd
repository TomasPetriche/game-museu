extends Node2D
class_name ArtefactSelectionManager

signal selection_ready
signal selection_not_ready


const SELECTION_LIMIT : int = 3

func _ready():
	for child in get_children():
		if child is ArtefactSelectable:
			child = child as ArtefactSelectable
			child.connect("selection_changed", self, "_check_selection")
	pass

func _check_selection():
	var select_count = 0
	var child_array : Array = get_children()
	for child in child_array:
		if child is ArtefactSelectable:
			child = child as ArtefactSelectable
			if child.selected:
				select_count += 1
	if select_count == SELECTION_LIMIT:
		for child in child_array:
			if child is ArtefactSelectable:
				child = child as ArtefactSelectable
				if not child.selected:
					child.hide()
		emit_signal("selection_ready")
	else:
		for child in child_array:
			if child is ArtefactSelectable:
				child = child as ArtefactSelectable
				if not child.selected:
					child.show()
		emit_signal("selection_not_ready")
	pass
