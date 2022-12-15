extends Control
class_name MainMenu

export (NodePath) var quit_path : NodePath = ""

func _ready():
	if OS.has_feature("web"):
		var quit_button = get_node_or_null(quit_path)
		if quit_button:
			quit_button.queue_free()
	pass


func _start_game():
	get_tree().call_group("Main", "go_to_scene", "test0")
	pass

func _quit():
	get_tree().call_group("Main", "quit_app")
	pass
