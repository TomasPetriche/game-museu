extends Node
class_name PlayerController



signal movement_changed (movement_direction)
signal just_interacted

var _previous_movement = Vector2()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	# Get Directions
	var direction_input : Vector2 = Vector2(
			-int(Input.is_action_pressed("gp_left")) + int(Input.is_action_pressed("gp_right")),
			-int(Input.is_action_pressed("gp_up")) 	+ int(Input.is_action_pressed("gp_down"))  );
	
	# Clear diagonals, priority dor vertical
	if abs(direction_input.y) >= .1:
		direction_input = direction_input * Vector2.DOWN
	else:
		direction_input = direction_input * Vector2.RIGHT

	# Emit Signal for change in movement
	if _previous_movement != direction_input:
		emit_signal("movement_changed", direction_input)
		_previous_movement = direction_input

	# Emit Signal for Interactions
	var interact_input = Input.is_action_just_pressed("gp_interact")
	if interact_input:
		emit_signal("just_interacted")
	pass
