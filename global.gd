extends Node

var Master_Volume = 1
var Music_Volume = 1
var Sound_Volume = 1

func sound_play(audio_stream_player, audio_file, gain):
	audio_stream_player.stream = audio_file
	audio_stream_player.volume_db = linear_to_db( (Master_Volume * (Sound_Volume)) * gain )
	audio_stream_player.play()

func music_play(audio_stream_player, audio_file, gain):
	audio_stream_player.stream = audio_file
	audio_stream_player.volume_db = linear_to_db( (Master_Volume * (Music_Volume)) * gain )
	audio_stream_player.play()
