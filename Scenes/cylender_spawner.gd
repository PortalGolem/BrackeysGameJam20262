extends Node3D

@export var noteQueue = []

var Cylender = preload("res://Objects/cylender.tscn")
var Note = preload("res://Objects/note.tscn")

func _ready():
	printNote("Hello Frank!", "pink")
	printNote("My name if Frankcheska Jeff. stop calling me Frank.", "yellow")
	printNote("HAHAHAHAHHAHAHAHA \n\n\n   -Bill From Accounting", "yellow")

func printNote(noteText, noteColor):
	noteQueue.append({"Text" = noteText, "Color" = noteColor})


func _on_timer_timeout() -> void:
	if noteQueue.size() > 0:
		var container = Cylender.instantiate()
		add_sibling(container)
		var note = Note.instantiate()
		container.add_sibling(note)
		container.contents = note
		container.position = position
		note.text = noteQueue[0]["Text"]
		note.color = noteQueue[0]["Color"]
		note.visible = false
		note.process_mode = Node.PROCESS_MODE_INHERIT
		noteQueue.remove_at(0)
