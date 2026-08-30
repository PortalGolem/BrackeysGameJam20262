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
	 Larry = {
		"VentricaID" = 2,
		"Name" = "Larry",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"Greeting" = [{"Text" = "ε(´｡•o•`)っ", "Target" = "Any", "Meta" = []}],
		"RandomNotes1" = [
		{"Text" = ": )", "Target" = "Any", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = ": )"}]},
		],
		"PerpetualNotes" = [],
		"SentNotes" = []
		},
	Bob = {
		"VentricaID" = 1,
		"Name" = "Bob",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"RandomNotes1" = [
		{"Text" = "Hello Everyone! This new mailing system is cooooooool!  -Mr. Bob Yes it is bob!", "Target" = "Any", "Meta" = []},
		],
		"Responses" = {
			"On It" = {"Text" = "Hello Everyone! This new mailing system is cooooooool!  -Mr. Bob Yes it is bob!", "Target" = "Any", "Meta" = []},
		},
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Meredith = {
		"VentricaID" = 3,
		"Name" = "Meredith",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"Responses" = {
			"On It" = {"Text" = "Hello Everyone! This new mailing system is cooooooool!  -Mr. Bob Yes it is bob!", "Target" = "Eli", "Meta" = []},
		},
		"Greeting" = [{"Text" = "Hello newbie! Just so you know, I'm keeping track of your accuracy. Better not fall too low, but theres no pressure!!", "Target" = "Any", "Meta" = []}],
		"RandomNotes1" = [
		{"Text" = "Hey everyone! How are you guys doing? Meri here!", "Target" = "Any", "Meta" = [{"Recipient" = "Target", "Sender" = "Meredith", "Return" = "Hello? Anyone"}]},
		{"Text" = "Hey Frank. I've noticed that your performance is slightly off from yesterday. Not to be theat person but make sure your working hard!", "Target" = "Frank", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Meredith, I've"}]}
		],
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Nathan = {
		"VentricaID" = 0,
		"Name" = "Nathan",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"Responses" = {
		},
		"RandomNotes1" = [
		{"Text" = "Could you direct me to the conference room Bertha?", "Target" = "Bertha", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Yes! It's"}]},
		{"Text" = "Jim, have you seen the new update for Gatya:The Impact", "Target" = "Frank", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Nathan, I'm"}]},
		{"Text" = "Hey Epstien, did you get the statistics on the cafateria spend this week?", "Target" = "Einstein", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Yeah, it"}]}
		],
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Jim = {
		"VentricaID" = 4,
		"Name" = "Jim",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"Responses" = {
		},
		"Greeting" = [{"Text" = "Hello newbie! Just so you know, I'm keeping track of your accuracy. Better not fall too low, but theres no pressure!!", "Target" = "Any", "Meta" = []}],
		"RandomNotes1" = [
		{"Text" = "Larry I swear to GOD if you block ONE MORE OF MY ANIME SITES I'm gonna BEAT YOU", "Target" = "Bertha", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "╭∩╮( ＾◡＾)╭∩╮╭∩╮( ＾◡＾)╭∩╮"}]},
		],
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Frank = {
		"VentricaID" = 4,
		"Name" = "Frank",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"Responses" = {
		},
		"Greeting" = [{"Text" = "Hello newbie! Just so you know, I'm keeping track of your accuracy. Better not fall too low, but theres no pressure!!", "Target" = "Any", "Meta" = []}],
		"RandomNotes1" = [
		{"Text" = "Larry I swear to GOD if you block ONE MORE OF MY ANIME SITES I'm gonna BEAT YOU", "Target" = "Larry", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "╭∩╮( ＾◡＾)╭∩╮╭∩╮( ＾◡＾)╭∩╮"}]},
		],
		"PerpetualNotes" = [],
		"SentNotes" = []
	}
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
