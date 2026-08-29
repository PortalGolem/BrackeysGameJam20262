extends Path3D

signal object_finished()
const movingCyl := preload("res://Objects/MovingCylender.tscn")
var queueSize := 0

func object_finished_singal():
	object_finished.emit()


func _on_cylender_spawner_add_note_to_queue() -> void:
	queueSize += 1
	

func _on_timer_timeout() -> void:
	if queueSize > 0:
		queueSize -= 1
		add_child(movingCyl.instantiate())
