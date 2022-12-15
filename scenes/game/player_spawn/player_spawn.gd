extends Position2D
class_name PlayerSpawn

signal player_ready

export (PackedScene) var player_packed : PackedScene

func _spawn_player():
	if player_packed:
		var instance := player_packed.instance() as Node2D
		instance.global_position = self.global_position
		get_parent().add_child(instance)
		get_parent().move_child(instance, 0)
	emit_signal ("player_ready")
	queue_free()
	pass
