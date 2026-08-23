class_name PostIt
extends Node2D

var postit = preload("res://Scenes/pop_up.tscn")

func create(text, color):
	var instance = postit.instantiate()
	add_child(instance)
	instance.text = text
	instance.color = color
	
