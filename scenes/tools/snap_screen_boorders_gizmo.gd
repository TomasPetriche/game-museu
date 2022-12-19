tool
extends Node2D
class_name SnapScreenBordersGizmo

export (bool) var active := false
export (Vector2) var screen_size : Vector2 = Vector2(1024, 600)
export (Vector2) var iterations : Vector2 = Vector2(3, 3)
export (Vector2) var offset : Vector2 = Vector2(0, 0)


func _ready():
	if OS.has_feature('standalone'):
		self.queue_free()
	pass


func _draw():
	if not Engine.editor_hint and active:
		return


	for i in range(10):
		for j in range(10):
			var x = i*screen_size.x + offset.x
			var y = j*screen_size.y + offset.y
			var border_rect: Rect2 = Rect2(Vector2(x, y), screen_size)
			draw_rect(border_rect, Color.red, false)
	pass


func _process(_delta):
	if not Engine.editor_hint:
		update()
	pass
	
