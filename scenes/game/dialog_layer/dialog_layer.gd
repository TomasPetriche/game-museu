extends CanvasLayer
class_name DialogLayer

signal dialog_completed

export (Array, Resource) var dialog_data : Array = []
var current_line_index : int = -1

func _ready():
	if dialog_data.size() != 0:
		_new_line()
	else:
		_end()

func _input(_event):
	if self.visible:
		if Input.is_action_just_pressed("ui_accept"):
			_new_line()

func _new_line():
	current_line_index += 1
	if current_line_index >= dialog_data.size():
		_end() 
		return
	
	var current_line_data = dialog_data[current_line_index] as DialogLineData
	
	$"%IconTexture".texture = current_line_data.character_texture
	$"%DialogLabel".text = current_line_data.text_line

func _end():
	emit_signal("dialog_completed")
	hide()
