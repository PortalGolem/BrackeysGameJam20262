extends Node

@export var contents:Node3D

var hasContents = true

func _on_cylender_inspect_object() -> void:
	if hasContents:
		contents.process_mode = Node.PROCESS_MODE_INHERIT
		contents.reparent(get_parent(), true)
		contents.position = position
