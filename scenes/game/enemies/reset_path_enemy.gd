extends Area2D
class_name ResetPathEnemy

const RESTART_DELAY = 1

export (NodePath) var follow_point_path : NodePath = ""
var follow_point : PathFollow2D = null

export (bool) var ping_poing_move : bool = true
export (float) var move_speed := 128.0

onready var sprite_offset_tween := [Vector2(0, -12), Vector2(0, -16)].duplicate(true)
var anim_time := 0.65

const move_tile_size = Vector2(64, 32)

func _ready():
	if not follow_point_path == "":
		follow_point = get_node(follow_point_path)
		follow_point.loop = not ping_poing_move
		
	
	var _err = null
	_err = self.connect("body_entered", self, "_check_body")
	_err = $AnimTween.connect("tween_all_completed", self, "_new_anim")
	_new_anim()
	pass

func _physics_process(delta):
	if follow_point:
		self.global_position = follow_point.global_position
		follow_point.offset += move_speed * delta
		if ping_poing_move and (follow_point.unit_offset == 0.0 or follow_point.unit_offset >= 1.0):
			move_speed *= -1
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
		# EMERGENCY
		var destroy_object := DestroyParent.new(RESTART_DELAY) 
		body.add_child(destroy_object, true)
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
