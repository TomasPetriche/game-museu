extends AudioStreamPlayer
class_name PlayerAudio

export (AudioStreamSample) var walk_sample : AudioStreamSample

const WALK_SFX := "walk_sfx"

#Sound Control
var current_sfx := ""


func _ready():
	var _err = connect("finished", self, "sound_completed")
	pass

func play_sfx( sfx_name : String, volume : float = 0.0, override : bool = false):

	if sfx_name == current_sfx and not override:
		return
	
	#Prepare play
	match (sfx_name):
		WALK_SFX:
			stream = walk_sample
			pitch_scale = 2.0
		var unrelated_name:
			print(unrelated_name, " is not a valid name")
			return
	current_sfx = sfx_name
	volume_db = volume
	play()
	pass

func sound_completed():
	stream = null
	current_sfx = ""
	pass

	