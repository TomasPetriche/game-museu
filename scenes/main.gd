extends Node
class_name Main


export (bool) var include_disclaimer_version : bool = false


export (Dictionary) var scenes : Dictionary
var _current_scene : String = ""


"""
Callbacks 
"""

func _enter_tree():
	self.add_to_group("Main")
	pass

func _ready():
	_start_app()
	pass

# Start App
func _start_app():
	if include_disclaimer_version or OS.has_feature("presentation"):
		go_to_scene("disclaimer")
	else:
		go_to_scene("MainMenu")
	pass

func go_to_scene(scene_id : String):
	# Deffered action
	if scene_id in scenes.keys():
		yield(get_tree(), "idle_frame")
		get_tree().call_group("FreeOnChangeScene", "queue_free")
		_current_scene = scene_id
		var new_instance := scenes[_current_scene].instance() as Node
		add_child(new_instance)
	else:
		print("\"%s\" does not exist in scenes dictionary.")
	pass

func restart_scene():
	get_tree().call_group("FreeOnChangeScene", "queue_free")
	var new_instance := scenes[_current_scene].instance() as Node
	add_child(new_instance)

func quit_app():
	get_tree().quit()
	pass
