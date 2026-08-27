class_name Drop

extends Node3D

signal trigger_dropped_function(object:Node3D)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_signal("dropObject"):
		body.dropObject.connect(_object_dropped_in_area)
		

func _on_area_3d_body_exited(body: Node3D) -> void:
	if  body.dropObject.is_connected(_object_dropped_in_area):
		body.dropObject.disconnect(_object_dropped_in_area)

func _object_dropped_in_area(object:Node3D) -> void:
	trigger_dropped_function.emit(object)
