extends Node

var score := 0

@onready var spawner := $CylenderSpawner
@export var randomNoteSpawnChancePerCycle := .5
@export var randomNoteSpawnRollCount := 2
@export var maxNoteSpawns := 2
var currentNotes = []
var notesSent := 0

var greetingSent := false

var people = {
	 Garry = {
			"VentricaID" = 2,
			"Name" = "Larr",
			"Color" = "yellow",
			"SystemTrust" = 1.0,
			"PerpetualChance" = 0.0,
			"RandomNotes1" = [
			{"Text" = ": )", "Target" = "Any", "Meta" = [{"Person" = "Target", "Return" = ": )"}]},
			"PerpetualNotes" = [],
			"SentNotes" = []},
}

func _ready() -> void:
	_on_timer_timeout()

func _on_timer_timeout() -> void:
	notesSent = 0
	for person in people:
		if not greetingSent and people[person].has("Greeting"):
			for greet in people[person]["Greeting"]:
				# Greetings disabled
				sendNotes(greet["Text"], people[person]["Color"], greet["Target"], people[person]["Name"], true, true)
				pass
		for i in randomNoteSpawnRollCount:
			if people[person]["PerpetualChance"] <= 0 and people[person]["SentNotes"].size() >= people[person]["RandomNotes1"].size():
				break
			if randf() < clampf(randomNoteSpawnChancePerCycle * people[person]["SystemTrust"], 0.0, 1.0):
				var selectedNote = {"Text" = "No way brochacho", "Target" = "Trash"}
				var isPerpetual:bool
				if randf() < people[person]["PerpetualChance"] or people[person]["SentNotes"].size() >= people[person]["RandomNotes1"].size():
					selectedNote = people[person]["PerpetualNotes"].pick_random()
					isPerpetual = true
				else:
					while true:
						selectedNote = people[person]["RandomNotes1"].pick_random()
						isPerpetual = false
						if selectedNote in people[person]["SentNotes"]:
							continue
						break
				sendNotes(selectedNote["Text"], people[person]["Color"], selectedNote["Target"], people[person]["Name"], isPerpetual)
		
	
	greetingSent = true
	
func handleNotes(note:Note, sentWithoutCannister:bool):
	var noteDict = null
	for n in currentNotes:
		if (n["Text"] == note.text):
			noteDict = n
	if noteDict == null:
		print("No notes!")
	
func sendNotes(text: String, color: String, target: String, origin: String, isPerpetual: bool, maxNoteOverride := false) -> void:
	if notesSent > maxNoteSpawns and not maxNoteOverride:
		return
	notesSent += 1
	spawner.printNote(text, color)
	currentNotes.append({"Text" = text, "Target" = target, "Origin" = origin})
	if not isPerpetual:
		people[origin]["SentNotes"].append({"Text" = text, "Target" = target})

func _ventricle_return_function(object:Node3D, ventricle:int):
	var parent = object.get_parent().get_parent()
	if parent is CylenderContents and parent.hasContents:
		handleNotes(parent.contents, false)
	if parent is Note:
		handleNotes(parent, true)


func _on_trash_can_trigger_dropped_function(object: Node3D) -> void:
	var parent = object.get_parent().get_parent()
	if parent is CylenderContents and parent.hasContents:
		handleNotes(parent.contents, false)
	if parent is Note:
		handleNotes(parent, true)
	object.queue_free()
