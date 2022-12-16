extends Position2D
class_name PlayerSpawn

"""
One Shot Player Spawn
"""

signal player_ready (player_instance)

export (PackedScene) var player_packed : PackedScene
export (bool) var skip_animation := false

func _ready():
	if skip_animation:
		call_deferred("_spawn_player")
	else:
		$AnimationPlayer.play("SpawnPlayer")
	pass

func _spawn_player():
	if player_packed:
		var instance := player_packed.instance() as Node2D
		instance.global_position = self.global_position
		get_parent().add_child(instance)
		get_parent().move_child(instance, get_index())
		emit_signal ("player_ready", instance)
	queue_free()
	pass
