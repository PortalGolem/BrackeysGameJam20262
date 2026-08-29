extends Node3D

var noteQueue = []
@export var noteSize := .5
@export var maxNotes := 5
@export var extraNotesPosition := Vector3.UP * 500

var Cylender = preload("res://Objects/cylender.tscn")
var Note = preload("res://Objects/note.tscn")

var stashedNotes = [null, null, null, null, null]
var hiddenStashedNotes := []

signal add_note_to_queue()

#func _ready():
	#printNote("Hello Frank!", "pink")
	#printNote("My name if Frankcheska Jeff. stop calling me Frank.", "yellow")
	#printNote("HAHAHAHAHHAHAHAHA \n\n\n   -Bill From Accounting", "yellow")

func printNote(noteText, noteColor):
	add_note_to_queue.emit()
	noteQueue.append({"Text" = noteText, "Color" = noteColor})


func _on_timer_timeout() -> void:
	if noteQueue.size() > 0:
		var container = Cylender.instantiate()
		add_sibling(container)
		var note = Note.instantiate()
		container.add_sibling(note)
		container.contents = note
		var positionToPlace := position
		var foundSlot := false
		for n in stashedNotes.size():
			if stashedNotes[n] == null:
				foundSlot = true
				print(n)
				positionToPlace = position + (Vector3.LEFT * (n * noteSize))
				stashedNotes[n] = container
				container.get_child(0).pickUpItem.connect(_pick_up_item)
				break
		if not foundSlot:
			positionToPlace = extraNotesPosition
			hiddenStashedNotes.append(container)
		container.position = positionToPlace
		note.text = noteQueue[0]["Text"]
		note.color = noteQueue[0]["Color"]
		note.visible = false
		note.process_mode = Node.PROCESS_MODE_INHERIT
		noteQueue.remove_at(0)


func _on_timer_2_timeout() -> void:
	if hiddenStashedNotes.size() == 0:
		return
	var positionToPlace := position
	for n in stashedNotes.size():
		if stashedNotes[n] == null:
			stashedNotes[n] = hiddenStashedNotes[0]
			positionToPlace = position + (Vector3.LEFT * (n * noteSize))
			hiddenStashedNotes[0].get_child(0).pickUpItem.connect(_pick_up_item)
			hiddenStashedNotes[0].position = positionToPlace
			hiddenStashedNotes.remove_at(0)
			break

func _pick_up_item(item:Item) -> void:
	print("Removed note from queue")
	stashedNotes[stashedNotes.find(item.get_parent())] = null
	item.disconnect("pickUpItem", _pick_up_item)
