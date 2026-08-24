class_name PostIt
extends Node

var postit = preload("res://Scenes/pop_up.tscn")

func _init(text, color):
	var instance = postit.instantiate()
	add_child(instance)
	instance.text = text
	instance.color = color
	
