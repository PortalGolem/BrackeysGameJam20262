class_name CylenderContents
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
			contents = object.get_parent()


func _on_item_drop_object(object: Node3D) -> void:
	global.sound_play($AudioStreamPlayer, load("res://Sounds/SFX for pipes/Container_Drop.mp3"), 0.3)
	pass # Replace with function body.

func _on_item_inspect_object() -> void:
	global.sound_play($AudioStreamPlayer, load("res://Sounds/SFX for pipes/Container_Open.mp3"), 0.3)
	pass # Replace with function body.

func _on_item_pick_up_item(item: Item) -> void:
	global.sound_play($AudioStreamPlayer, load("res://Sounds/SFX for pipes/Container_PickUp.mp3"), 0.3)
	pass # Replace with function body.
