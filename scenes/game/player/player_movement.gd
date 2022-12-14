extends Node
class_name PlayerMovement

"""

Snap Movement using Tweens

"""

signal moved
signal movement_changed (move_direction)

export (Vector2) var move_tile_size = Vector2(64, 32)
export (float) var move_time : float = .5

var is_moving : bool = false 
var _linear_velocity : Vector2 = Vector2()
var _current_direction : Vector2 = Vector2()
onready var _main_body := get_parent() as KinematicBody2D



func _ready():
	var _err = $MoveTween.connect("tween_completed", self, "_process_tween_end")
	pass

func _physics_process(_delta):
	if not self.is_moving and _current_direction != Vector2():
		_process_snap_movement()
	pass

func update_movement_direction(new_direction):
	_current_direction = new_direction 
	pass


static func card2iso(vector : Vector2) -> Vector2:
	if vector == Vector2.UP:
		vector = Vector2(1, -1)
	elif vector == Vector2.DOWN:
		vector = Vector2(-1, 1)
	elif vector == Vector2.RIGHT:
		vector = Vector2(1, 1)
	elif vector == Vector2.LEFT:
		vector = Vector2(-1, -1)
	return vector


func _process_snap_movement():
	var tween = $MoveTween
	var init_position = _main_body.global_position
	var iso_direction =  card2iso(_current_direction)


	var final_position = init_position + (iso_direction * move_tile_size)
	tween.interpolate_property(_main_body, "global_position",
			init_position, final_position, 
			move_time)
	tween.start()
	emit_signal("moved")
	emit_signal("movement_changed", iso_direction)
	self.is_moving = true
	pass

func _process_tween_end(_object : Object, key : NodePath):
	if key == (":global_position"):
		emit_signal("movement_changed", Vector2.ZERO)
		self.is_moving = false
	pass
