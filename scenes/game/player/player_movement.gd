extends Node
class_name PlayerMovement

"""

Snap Movement using Tweens
Require Tween as child

"""

signal hit
signal moved
signal movement_changed (move_direction)

export (Vector2) var move_tile_size = Vector2(64, 32)
export (float) var move_time : float = .5
export (bool) var can_bounce_wall : bool = true

var is_moving : bool = false 
var go_back_movement: bool = false
var _previous_velocity : Vector2 = Vector2()
var _current_direction : Vector2 = Vector2()
onready var _main_body : KinematicBody2D = get_parent() as KinematicBody2D



func _ready():
	if get_node_or_null("MoveTween") == null:
		var new_tween = Tween.new()
		new_tween.name = "MoveTween"
		add_child(new_tween)
	var _err = $MoveTween.connect("tween_completed", self, "_process_tween_end")
	pass

func _physics_process(_delta):
	if not is_moving and _current_direction != Vector2():
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
	var velocity = (iso_direction * move_tile_size)
	
	# If does't collides with wall
	if !_main_body.test_move(_main_body.transform, velocity):
		var final_position = init_position + velocity
		tween.interpolate_property(_main_body, "global_position",
				init_position, final_position, 
				move_time)
		tween.start()
		is_moving = true
		emit_signal("moved")
		emit_signal("movement_changed", iso_direction)
	# If collide with wall
	else:
		if can_bounce_wall:
			velocity = velocity/2.0
			var final_position = init_position + (velocity)
			tween.interpolate_property(_main_body, "global_position",
					init_position, final_position,
					move_time/2.0)
			tween.start()
			_previous_velocity = velocity
			go_back_movement = true
			is_moving = true
			emit_signal("hit")
			emit_signal("movement_changed", iso_direction)
		else:
			emit_signal("hit")
	pass

func _process_tween_end(_object : Object, key : NodePath):
	if key == (":global_position"):
		if go_back_movement:
			go_back_movement = false
			var tween = $MoveTween
			var init_position = _main_body.global_position
			var final_position = init_position - _previous_velocity
			tween.interpolate_property(_main_body, "global_position",
				init_position, final_position,
				move_time/2.0)
			tween.start()
		else:
			emit_signal("movement_changed", Vector2.ZERO)
			is_moving = false
	pass
