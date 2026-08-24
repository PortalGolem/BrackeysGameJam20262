extends Node3D

var noteQueue = []

func printNote(noteText, noteColor):
	noteQueue.append({"Text" = noteText, "Color" = noteColor})


func _on_timer_timeout() -> void:
	if noteQueue.size() > 0:
		
		noteQueue.remove_at(0)
