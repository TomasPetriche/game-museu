extends AnimationPlayer
class_name PlayerAnimation

"""
Animation States Names
	- Movement
"""
const IDLE            = "player_idle"
const WALK_RIGHT_UP   = "player_walk_right_up"
const WALK_LEFT_UP    = "player_walk_left_up"
const WALK_RIGHT_DOWN = "player_walk_right_down"
const WALK_LEFT_DOWN  = "player_walk_left_down"


func _set_iso_movement_animation(move_direction: Vector2):
	match(move_direction):
		Vector2.ZERO:
			self.play(IDLE)
		Vector2(1,1):
			self.play(WALK_RIGHT_DOWN)
		Vector2(-1,1):
			self.play(WALK_LEFT_DOWN)
		Vector2(1,-1):
			self.play(WALK_RIGHT_UP)
		Vector2(-1,-1):
			self.play(WALK_LEFT_UP)
	pass

