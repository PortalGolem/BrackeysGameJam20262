class_name PostIt
extends Node

var postit = preload("res://Scenes/Menus/pop_up.tscn")

func _init(text, color = "yellow", postit_sprite = ""):
	var instance = postit.instantiate()
	add_child(instance)
	instance.text = text
	instance.color = color
	instance.postit_sprite = postit_sprite
	
