extends Timer
class_name DestroyParent

# Serve to destroy parent


func _init( time : float, autoplay : bool = true):
	self.autostart = autoplay
	self.wait_time = time
	pass

func _enter_tree():
	var _err =  self.connect("timeout", self,"_destroy")


func _destroy():
	var parent = get_parent() as Node
	if parent != null:
		parent.queue_free()
	else:
		self.queue_free()
	pass
