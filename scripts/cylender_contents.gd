extends Node

@export var contents:Node3D
@export var notePositionOffset:Vector3 = Vector3.ZERO

var hasContents = true

func _on_cylender_inspect_object() -> void:
	if hasContents:
		hasContents = false
		contents.process_mode = Node.PROCESS_MODE_INHERIT
		contents.visible = true
		contents.global_position = $Item.global_position + notePositionOffset
		contents.reparent(get_parent(), true)
		

func _on_dropable_trigger_dropped_function(object: Node3D) -> void:
		print("Tried to grab object " + str(object))
		if object is Item and object.canPutInCyl and not hasContents:
			hasContents = true
			object.process_mode = Node.PROCESS_MODE_DISABLED
			object.visible = false
			object.reparent(get_viewport(), true)
			contents = object
