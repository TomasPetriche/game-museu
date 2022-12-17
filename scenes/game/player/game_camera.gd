extends Camera2D
class_name GameCamera


enum CAMERA_MODE {TOP_LEFT, FOLLOW, SNAP}
export (CAMERA_MODE) var current_mode := CAMERA_MODE.TOP_LEFT setget _set_camera_mode

var pivot : Node2D = null
var screen_size: Vector2 = Vector2(1024, 600)


func _ready():
	process_mode =Camera2D.CAMERA2D_PROCESS_PHYSICS
	_set_camera_mode(current_mode)
	pass

func _input(event):
	if event is InputEventKey:
		event = event as InputEventKey
		if event.scancode == KEY_TAB and (event.is_pressed() and not event.echo):
			self.current_mode = (int(current_mode) + 1)% 3
	pass

func _process(_delta):
	_update_camera()
	pass

func _set_pivot(new_pivot : Node2D):
	pivot = new_pivot
	_update_camera()
	pass

func _set_camera_mode(new_mode):
	var previous_mode = current_mode
	current_mode = new_mode
	#print("CAMERA SET ", current_mode)
	
	match (new_mode):
		CAMERA_MODE.TOP_LEFT:
			anchor_mode = ANCHOR_MODE_FIXED_TOP_LEFT
			call_deferred("set", "global_position", Vector2.ZERO)
			pass
		CAMERA_MODE.FOLLOW:
			anchor_mode = ANCHOR_MODE_DRAG_CENTER
			if pivot:
				call_deferred("set", "global_position", pivot.global_position)
			pass
		CAMERA_MODE.SNAP:
			anchor_mode = ANCHOR_MODE_FIXED_TOP_LEFT
			_update_snap_position()
			pass
		_:
			current_mode = previous_mode
			print("INVALID CAMERA MODE - ", get_path())

func _update_camera():
	match(current_mode):
		CAMERA_MODE.TOP_LEFT:
			pass
		CAMERA_MODE.FOLLOW:
			if pivot:
				call_deferred("set", "global_position", pivot.global_position)
			pass
		CAMERA_MODE.SNAP:
			if pivot:
				var camera_rect := _get_camera_rect() as Rect2
				if not camera_rect.has_point(pivot.global_position):
					_update_snap_position()
	pass

func _update_snap_position():
	if pivot:
		global_position = pivot.global_position
	var new_position := Vector2(
			int(global_position.x) - int(global_position.x)%int(screen_size.x),
			int(global_position.y) - int(global_position.y)%int(screen_size.y)
			)
	call_deferred("set", "global_position", new_position)

func _get_camera_rect() -> Rect2:
	return Rect2(global_position, screen_size)
