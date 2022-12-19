extends Area2D
class_name PusherEnemy


export (Vector2) var position1 := Vector2()
export (Vector2) var position2 := Vector2()
export (float) var move_time := 1.0

onready var sprite_offset_tween := [Vector2(0, -12), Vector2(0, -16)].duplicate(true)
export (float) var anim_time := 0.65

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

func _new_anim():
	$AnimTween.interpolate_property($Sprite, "offset", sprite_offset_tween[0], sprite_offset_tween[1], anim_time)
	$AnimTween.start()
	sprite_offset_tween.invert()
	pass
	
func _check_body(body: Node):
	print(body.name)
	pass
