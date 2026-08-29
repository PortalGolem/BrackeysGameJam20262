extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	loop_music()
	volume_db = linear_to_db((global.Master_Volume * (global.Music_Volume)))
	pass

func loop_music():
	if !playing:
		global.music_play($".", load(global.Music))
