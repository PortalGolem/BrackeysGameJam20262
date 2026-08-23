class_name Drop

extends Node3D

signal trigger_dropped_function

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Item and body.has_signal("dropObject"):
		body.dropObject.connect(_object_dropped_in_area)
		

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Item and body.dropObject.is_connected(_object_dropped_in_area):
		body.dropObject.disconnect(_object_dropped_in_area)

func _object_dropped_in_area(position) -> void:
	trigger_dropped_function.emit()
