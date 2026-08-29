extends Node

var Master_Volume = 1
var Music_Volume = 1
var Sound_Volume = 1
var Main_Font = "res://Assets/UIAssets/PlayfairDisplay-VariableFont_wght.ttf"
var Music = null

func sound_play(audio_stream_player, audio_file, gain = 1):
	audio_stream_player.stream = audio_file
	audio_stream_player.volume_db = linear_to_db( (Master_Volume * (Sound_Volume)) * gain )
	audio_stream_player.play()


func music_play(audio_stream_player, audio_file):
	audio_stream_player.stream = audio_file
	audio_stream_player.volume_db = linear_to_db((Master_Volume * (Music_Volume)))
	audio_stream_player.play()

func gen_random_choice(choices):
	#randomize() # Should probably put randomize() outside,
					# since it only needs to be called once per game
	return choices[randi() % choices.size() -1]
