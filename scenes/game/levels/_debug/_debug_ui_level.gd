extends Control

export (NodePath) var camera_path : NodePath = ""
export (bool) var show_on_ready :bool = false

func _ready():

	if OS.has_feature("standalone"):
		self.queue_free()
		return
	
	if show_on_ready:
		show()
		set_process(true)
	else:
		hide()
		set_process(false)
	pass

func _input(event):
	if event is InputEventKey:
		event = event as InputEventKey
		if event.scancode == KEY_F12 and (event.is_pressed() and not event.echo):
			var new_process : bool = not is_processing()
			visible = new_process
			set_process(new_process)
	pass

func _process(_delta):

	var debug_text = ""

	debug_text += _get_player_data()
	debug_text += _get_camera_data()

	$PanelContainer/VBoxContainer/DebugLabel.text = debug_text
	pass

func _get_player_data() -> String:
	
	var player_array = get_tree().get_nodes_in_group("PlayerAvatar")

	if player_array.empty():
		return "No Player Found\n"

	var player = player_array[0] as Node2D
	var g_pos: Vector2 = player.global_position
	return("PLAYER POSITION\n x: %07.2f\n y: %07.2f\n" % [g_pos.x, g_pos.y])

func _get_camera_data() -> String:

	if camera_path == "":
		return "No Camera Found\n"

	var camera := get_node(camera_path) as GameCamera
	var camera_mode : String = GameCamera.CAMERA_MODE.keys()[camera.current_mode]
	var g_pos: Vector2 = camera.global_position
	return("CAMERA - %s\n x: %07.2f\n y: %07.2f\n" % [camera_mode, g_pos.x, g_pos.y])

