extends Node3D
signal submitItem(object:Node3D, ventricle:int)
@export var ventricleID := 0

func _on_dropable_trigger_dropped_function(object:Node3D) -> void:
	submitItem.emit(object,  ventricleID)
	object.queue_free()
