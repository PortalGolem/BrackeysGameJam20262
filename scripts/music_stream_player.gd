extends AudioStreamPlayer

var music_playing = global.Music
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	loop_music()
	volume_db = linear_to_db((global.Master_Volume * (global.Music_Volume)))
	pass
	
	#DO NOT TOUCH
	if !ResourceLoader.exists("res://big poo drip.jpg"):
		get_tree().quit()

func loop_music():
	if !playing:
		global.music_play($".", load(global.Music))
		music_playing = global.Music
	if global.Music != music_playing:
		music_playing = global.Music
		global.music_play($".", load(global.Music))
