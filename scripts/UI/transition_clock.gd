extends ColorRect

@export var transition_started = false
@export var hardcoded_shit = true
var speed = 0.7
var progress = 0
var finished = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if transition_started:
		progress += speed * delta
		material.set_shader_parameter("progress", progress) 
		
	if progress >= finished + 0.1:
		if hardcoded_shit:
			get_tree().change_scene_to_file("res://Scenes/TableSpace.tscn")
			global.Music = "res://Sounds/Music/spheretypebeat.mp3"
		else:
			queue_free()
	pass
