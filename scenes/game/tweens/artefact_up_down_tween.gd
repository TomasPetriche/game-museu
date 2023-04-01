extends Tween
class_name ArtefactTween

"""
Change sprite offset fromVector2 to Vector2
"""


export (bool) var active : bool = true

export (Vector2) var plus_offset : Vector2 = Vector2(0, -8)
export (float) var tween_time :float = .8

export (NodePath) var sprite_path : NodePath
export (NodePath) var shadow_path : NodePath

onready var main_sprite   : Sprite = get_node_or_null (sprite_path)
onready var shadow_sprite : Sprite = get_node_or_null (shadow_path)
onready var base_offset : Vector2 = main_sprite.offset

func _ready():
	if active:
		_go_up()
	pass 

func _go_up():
	var _err = null
	_err = interpolate_property(main_sprite, "offset",
			base_offset, main_sprite.offset + plus_offset,
			tween_time)
	_err = interpolate_property(shadow_sprite, "scale",
			Vector2(.75, .75), Vector2(.5, .5),
			tween_time)	
	_err = start()

func _go_down():
	var _err = null
	_err = interpolate_property(main_sprite, "offset",
			main_sprite.offset, base_offset,
			tween_time)
	_err = interpolate_property(shadow_sprite, "scale",
			Vector2(.5, .5), Vector2(.75, .75),
			tween_time)	
	_err = start()

func _on_tween_completed(object:Object, key:NodePath):
	if object == main_sprite and key == ":offset":
		if main_sprite.offset == base_offset:
			_go_up()
		else:
			_go_down()
	pass 

