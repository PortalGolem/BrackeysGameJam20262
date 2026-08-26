extends Node

var score := 0

@onready var spawner = $CylenderSpawner

var Garry := {"RandomNotes1" = [
			{"Text" = "Hey Zenith! Whats up?", "Target" = "Zenith"},
			{"Text" = "Terry, could you submit the report due on thursday?", "Target" = "Zenith"},
			{"Text" = "Whats going on with the coffee machine?", "Target" = "Any"},
			{"Text" = "Larry, did you finish fixing the projector?", "Target" = "Larry"}],
			"PerpetualNotes" = []}
var Terry := {"RandomNotes1" = [
			{"Text" = "Larry, did you turn my computer off and on again like I asked?", "Target" = "Larry"},
			{"Text" = "I'm new here, does anyone know where the board room is?", "Target" = "Any"},
			{"Text" = "Did you see the sports game last night Larry?", "Target" = "Larry"},
			{"Text" = "Zenith, did you see that episode of 'That's Just Kevin?'", "Target" = "Zenith"}],
			"PerpetualNotes" = []}
var Larry := {
			"RandomNotes1" = [],
			"PerpetualNotes" = [
			{"Text" = ":)", "Target" = "Any"}, {"Text" = "o_O", "Target" = "Any"}]}
var Zenith := {"RandomNotes1" = [
			{"Text" = "PSA to Garry: Don't leave your sandles in the microwave, we eat out of that", "Target" = "Garry"},
			{"Text" = "The coffee machine has been moved to the board room.", "Target" = "Any"},
			{"Text" = "I love you Larry...", "Target" = "Any"},
			{"Text" = "Terry, could you come over to HR, I need to test out my new stand up routine", "Target" = "Terry"},
			{"Text" = "Please use the printer for only work purposes. (That means you Garry)", "Target" = "Garry"}],
			"PerpetualNotes" = []}

# This is the core of the game as a whole.
# Story lines will be stored for each character to represent their
# knowlage of the current events. This will be done in a dictionary.
# the dictionary will keep track of each type of event as a string.
# the game will try to catch up on what notes need to be sent in the
# timer controlled function.

# in addition to this core story line the characters will have a variable
# that determines how much they respect the mail system and that will
# influence storylines starting, ocassionally how they progress and
# also how many notes they send.

# in addition to the hard coded storylines and depending upon the status of
# each character will also have a chance to write random notes from a pool
# said pool can both start storylines and provide filler notes.

# 
func _on_timer_timeout() -> void:
	#Hey Zenith! The new mail guy is here so we can send messages.
	pass # Replace with function body.
