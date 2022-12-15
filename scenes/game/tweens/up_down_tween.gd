extends Tween
class_name UpDownTween

"""
Change sprite offset fromVector2 to Vector2
"""
export (Vector2) var plus_offset : Vector2 = Vector2(0, -8)
export (float) var tween_time :float = .8

onready var sprite =get_parent()
onready var base_offset : Vector2 = sprite.offset

func _ready():
	_go_up()
	pass 

func _go_up():
	var _err = null
	_err = interpolate_property(sprite, "offset",
			base_offset, sprite.offset + plus_offset,
			tween_time)
	_err = start()

func _go_down():
	var _err = null
	_err = interpolate_property(sprite, "offset",
			get_parent().offset, base_offset,
			tween_time)
	_err = start()

func _on_tween_completed(object:Object, key:NodePath):
	if object == sprite and key == ":offset":
		if sprite.offset == base_offset:
			_go_up()
		else:
			_go_down()
	pass 

