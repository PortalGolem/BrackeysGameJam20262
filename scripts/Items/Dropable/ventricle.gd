extends Node3D
signal submitItem(object:Node3D, ventricle:int)
@export var ventricleID := 0

var sound_open = preload("res://Sounds/Ventitties/venboobyopen/venboobyopen.wav")
@onready var ventricleVisual := $VentricleHover
func _on_dropable_trigger_dropped_function(object:Node3D) -> void:
	submitItem.emit(object,  ventricleID)
	$AudioStreamPlayer3D.stream = sound_open
	$AudioStreamPlayer3D.play()
	object.queue_free()



func _on_dropable_body_entered(body: Node3D) -> void:
	if body is Item:
			ventricleVisual.visible = true
	for node in body.get_children():
		if node is Item:
			ventricleVisual.visible = true


func _on_dropable_body_exited(body: Node3D) -> void:
	if body is Item:
			ventricleVisual.visible = false
	for node in body.get_children():
		if node is Item:
			ventricleVisual.visible = false
