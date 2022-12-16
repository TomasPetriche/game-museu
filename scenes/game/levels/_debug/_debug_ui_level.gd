extends Control

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

	$PanelContainer/DebugLabel.text = debug_text
	pass

func _get_player_data() -> String:
	
	var player_array = get_tree().get_nodes_in_group("PlayerAvatar")

	if player_array.empty():
		return "No Player Found"

	var player = player_array[0] as Node2D
	var g_pos: Vector2 = player.global_position
	return "PLAYER:\n" + ("POSITION\n x:%7.2f y:%7.2f\n" % [g_pos.x, g_pos.y])