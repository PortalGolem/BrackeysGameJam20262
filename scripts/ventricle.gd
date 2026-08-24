extends Node3D
signal submitItem(object:Node3D, ventricle:int)
@export var ventricleID := 0

var sound_open = preload("res://Sounds/Ventitties/venboobyopen/venboobyopen.wav")
func _on_dropable_trigger_dropped_function(object:Node3D) -> void:
	submitItem.emit(object,  ventricleID)
	$AudioStreamPlayer3D.stream = sound_open
	$AudioStreamPlayer3D.play()
	object.queue_free()
