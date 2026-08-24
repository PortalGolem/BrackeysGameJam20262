extends Node

@export var contents:Node3D
@export var notePositionOffset:Vector3 = Vector3.ZERO

var hasContents = true

func _on_cylender_inspect_object() -> void:
	if hasContents:
		hasContents = false
		contents.process_mode = Node.PROCESS_MODE_INHERIT
		contents.visible = true
		contents.position = $Item.position + notePositionOffset
		contents.reparent(get_parent(), true)
		
