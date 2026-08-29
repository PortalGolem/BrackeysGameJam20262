class_name Note

extends Node3D
var _inst:PostIt 

@export var text = "wassup"
@export var color = "rand"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	


func _on_item_inspect_object() -> void:
	if _inst == null or !is_instance_valid(_inst):
		_inst = PostIt.new(text, color)
		add_child(_inst)
	pass # Replace with function body.
