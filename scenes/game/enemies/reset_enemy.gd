extends Area2D
class_name ResetEnemy

const RESTART_DELAY = 1

export (Vector2) var position1 := Vector2()
export (Vector2) var position2 := Vector2()
export (float) var move_time := 1.0

onready var sprite_offset_tween := [Vector2(0, -12), Vector2(0, -16)].duplicate(true)
var anim_time := 0.65

const move_tile_size = Vector2(64, 32)

func _ready():
	var _err = null
	_err = self.connect("body_entered", self, "_check_body")
	_err = $MoveTween.connect("tween_all_completed", self, "_new_move")
	_new_move()
	_err = $AnimTween.connect("tween_all_completed", self, "_new_anim")
	_new_anim()
	pass
	

func _new_move():
	$MoveTween.interpolate_property(self, "global_position", position1, position2, move_time)
	$MoveTween.start()
	var temp := position1
	position1 = position2
	position2 = temp
	pass

func _new_anim():
	$AnimTween.interpolate_property($Sprite, "offset", sprite_offset_tween[0], sprite_offset_tween[1], anim_time)
	$AnimTween.start()
	sprite_offset_tween.invert()
	pass
	
func _check_body(body: Node2D):
	if body.is_in_group("PlayerAvatar"):
		body = body as PlayerAvatar
		body._fade()
		yield(get_tree().create_timer(RESTART_DELAY), "timeout")
		get_tree().call_group("PlayerSpawn", "_spawn_player")
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
