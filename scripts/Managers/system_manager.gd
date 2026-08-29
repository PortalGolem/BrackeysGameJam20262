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
			"VentricaID" = 0,
			"Name" = "Garry",
			"Color" = "yellow",
			"SystemTrust" = 1.0,
			"PerpetualChance" = 0.0,
			"RandomNotes1" = [
			{"Text" = "Hey Zenith! Whats up?", "Target" = "Zenith"},
			{"Text" = "Terry, could you submit the report due on thursday?", "Target" = "Zenith"},
			{"Text" = "Whats going on with the coffee machine?", "Target" = "Any"},
			{"Text" = "Larry, did you finish fixing the projector?", "Target" = "Larry"}],
			"PerpetualNotes" = [],
			"SentNotes" = []},
		Terry = {
			"VentricaID" = 1,
			"Name" = "Terry",
			"Color" = "pink",
			"SystemTrust" = 1.0,
			"PerpetualChance" = 0.0,
			"RandomNotes1" = [
			{"Text" = "Larry, did you turn my computer off and on again like I asked?", "Target" = "Larry"},
			{"Text" = "I'm new here, does anyone know where the board room is?", "Target" = "Any"},
			{"Text" = "Did you see the sports game last night Larry?", "Target" = "Larry"},
			{"Text" = "Zenith, did you see that episode of 'That's Just Kevin?'", "Target" = "Zenith"}],
			"PerpetualNotes" = [],
			"Greeting" = [{"Text" = "Hey there new guy! I'm also kind of new around here " +
			"But I started out just like you in the mail room. I was only 'interim mail " +
			"officer' whereas you're full time but hopefully I can give you some pointers."
			, "Target" = "Any"}, 
			{"Text" = "First off you can throw these notes in the trash to your right " +
			"when you're done with them, go ahead and throw away the whole canister we " +
			"have a million of them.", "Target" =  "Trash"},
			{"Text" = "Second, its a little hard to remember names so I left sticky notes " +
			"on the pipes for who they go to. Everyone here (except Larry) uses one color note to" +
			"talk to other people, so if they don't say you can usually tell", "Target" = "Trash"},
			{"Text" = "The last thing you should know is that we have a terrible label system so" +
			"go ahead and read the notes to see who their supposed to go to. Good luck!", "Target" = "Trash"}],
			"SentNotes" = []},
		Larry = {
			"Ventrica" = 2,
			"Name" = "Larry",
			"Color" = "rand",
			"SystemTrust" = 1.0,
			"PerpetualChance" = 1.0,
			"RandomNotes1" = [],
			"PerpetualNotes" = [
			{"Text" = ":)", "Target" = "Any"}, {"Text" = "o_O", "Target" = "Any"}],
			"SentNotes" = []},
		Zenith = {
			"VentricaID" = 3,
			"Name" = "Zenith",
			"Color" = "blue",
			"SystemTrust" = 1.0,
			"PerpetualChance" = 0.0,
			"RandomNotes1" = [
			{"Text" = "PSA to Garry: Don't leave your sandles in the microwave, we eat out of that", "Target" = "Garry"},
			{"Text" = "The coffee machine has been moved to the board room.", "Target" = "Any"},
			{"Text" = "I love you Larry...", "Target" = "Larry"},
			{"Text" = "Terry, could you come over to HR, I need to test out my new stand up routine", "Target" = "Terry"},
			{"Text" = "Please use the printer for only work purposes. (That means you Garry)", "Target" = "Garry"}],
			"PerpetualNotes" = [],
			"Greeting" = [{"Text" = "Hey Terry, there's a new mail person. We can send messages again!", "Target" = "Terry"}],
			"SentNotes" = []}
}

func _ready() -> void:
	_on_timer_timeout()

func _on_timer_timeout() -> void:
	notesSent = 0
	for person in people:
		if not greetingSent and people[person].has("Greeting"):
			for greet in people[person]["Greeting"]:
				# Greetings disabled
				#sendNotes(greet["Text"], people[person]["Color"], greet["Target"], people[person]["Name"], true, true)
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
	pass
