extends PathFollow3D

@export var speed:float
signal reached_end()
func _ready() -> void:
	reached_end.connect(get_parent().object_finished_singal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1.0:
		reached_end.emit()
		queue_free()
