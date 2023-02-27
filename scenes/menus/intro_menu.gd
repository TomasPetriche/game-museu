extends Node2D
class_name Menu


export (String) var star_scene_id : String = ""


func _next():
	get_tree().call_group("Main", "go_to_scene", star_scene_id)
	pass # Replace with function body.
