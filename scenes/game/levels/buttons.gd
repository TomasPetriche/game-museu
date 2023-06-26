extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DialogLayer_dialog_completed():
	var bnt_left = get_node ("bnt_left")
	bnt_left.visible = true
	
	var bnt_right = get_node ("bnt_right")
	bnt_right.visible = true
	
	var bnt_up = get_node ("bnt_up")
	bnt_up.visible = true
	
	var bnt_down = get_node ("bnt_down")
	bnt_down.visible = true
	
	pass # Replace with function body.
