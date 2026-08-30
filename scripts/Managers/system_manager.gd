extends Node

var score := 0

signal recieveFirstNote()

@onready var spawner := $CylenderSpawner
@export var randomNoteSpawnChancePerCycle := .5
@export var randomNoteSpawnRollCount := 2
@export var maxNoteSpawns := 2
@export var maxConversations = 2
var currentNotes = []
var notesSent := 0

var currentConversations = [null, null]

var greetingSent := false
var currentAccuracyQuality = 10

var activeConversations:int = 0

var ventricleIds = ["Nathan", "Bob", "Larry", "Meredith", "Jim", "Frank", "Einstein", "Bertha", "Gertrude", "Eli", "Boss"]

var people = {
	 Larry = {
		"VentricaID" = 2,
		"Name" = "Larry",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"Greeting" = [{"Text" = "ε(´｡•o•`)っ", "Target" = "Any", "Meta" = []}],
		"RandomNotes1" = [
		],
		"Conversation" = {
			"╭∩╮( ＾◡＾)╭∩╮╭∩╮( ＾◡＾)╭∩╮" =  {"Text" = "╭∩╮( ＾◡＾)╭∩╮╭∩╮( ＾◡＾)╭∩╮", "Target" = "Jim", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "What did"}]},
			"¯\\_(ツ)_/¯" = {"Text" = "¯\\_(ツ)_/¯", "Target" = "Jim", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "off you"}]},
			"( ദ്ദി ˙ᗜ˙ )" = {"Text" = "( ദ്ദി ˙ᗜ˙ )", "Target" = "Frank", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "I know"}]},
			"(¬_¬\")" = {"Text" = "(¬_¬\")", "Target" = "Frank", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Thanks Larry"}]},
			"🫂" = {"Text" = "🫂", "Target" = "Frank", "Meta" = []},
			"(¬_¬\"')" =  {"Text" = "(¬_¬\"')", "Target" = "Boss", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "I need"}]},
			"(¬_¬\"'')" =  {"Text" = "(¬_¬\"'')", "Target" = "Boss", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "I'll get"}]},
			"( ˶ˆᗜˆ˵ )" = {"Text" = "( ˶ˆᗜˆ˵ )", "Target" = "Boss", "Meta" = []},
		},
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
		{"Text" = "Hello Everyone! This new mailing system is cooooooool!  \n\n-Mr. Bob", "Target" = "Any", "Meta" = []},
		],
		"Conversation" = {
			"On it!" = {"Text" = "On it!", "Target" = "Eli", "Meta" = []}
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
		"Greeting" = [{"Text" = "Hello newbie! Just so you know, I'm keeping track of your accuracy. Better not fall too low, but theres no pressure!! \n\nBest, \nMeredith.", "Target" = "Any", "Meta" = []}],
		"RandomNotes1" = [
		#{"Text" = "Hey everyone! How are you guys doing? Meri here!", "Target" = "Any", "Meta" = [{"Recipient" = "Target", "Sender" = "Meredith", "Return" = "Hello? Anyone"}]},
		{"Text" = "Hey Frank. I've noticed that your performance is slightly off from yesterday. Not to be theat person but make sure your working hard!", "Target" = "Frank", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Meredith, I've"}]}
		],
		"Conversation" = {
			#"Hello? Anyone" = {"Text" = "Hello? Anyone get my message?", "Target" = "Any", "Meta" = [{"Recipient" = "Target", "Sender" = "Meredith", "Return" = "Is my"}]},
			#"Is my" = {"Text" = "Is my tube broken?", "Target" = "Any", Meta = [{"Recipient" = "Target", "Sender" = "Meredith", "Return" = "Mail guy,"}]},
			#"Mail guy," = {"Text" = "Mail guy, you suck at your job.", "Target" = "Any", Meta = []},
			"Still not" = {"Text" = "Still not an excuse Frank! Think about the shareholders, they need to make their hard earned money too!", "Target" = "Frank", "Meta" = []}
		},
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Nathan = {
		"VentricaID" = 0,
		"Name" = "Nathan",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"RandomNotes1" = [
		{"Text" = "Could you direct me to the conference room Bertha? \n\nBest,\nNathan", "Target" = "Bertha", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Yes! It's"}]},
		{"Text" = "Jim, have you seen the new update for Gatya:The Impact?", "Target" = "Jim", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Nathan, I'm"}]},
		{"Text" = "Hey Epstien, did you get the statistics on the cafeteria spend this week?", "Target" = "Einstein", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Yeah, it"}]}
		],
		"Conversation" = {
			"But sending" = {"Text" = "But sending notes is way cooler.", "Target" = "Jim", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Whatever you"}]},
			"Hey, your" = {"Text" = "Hey, your doing the same thing as me! Why is it weird when I do it??", "Target" = "Jim", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "It's because"}]},
		},
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Jim = {
		"VentricaID" = 4,
		"Name" = "Jim",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"RandomNotes1" = [
		{"Text" = "Larry I swear to GOD if you block ONE MORE OF MY ANIME SITES I'm gonna BEAT YOUR @^&$%*& ASS. \n\nWorst,\nJim", "Target" = "Bertha", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "╭∩╮( ＾◡＾)╭∩╮╭∩╮( ＾◡＾)╭∩╮"}]},
		],
		"Conversation" = {
			"What did" = {"Text" = "What did I even do to deserve this... I can get my work done and watch shows at the same time.", "Target" = "Larry", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "¯\\_(ツ)_/¯"}]},
			"off you" = {"Text" = "@&*$%^*@&# off you mute #&^$%*.", "Target" = "Larry", "Meta" = []},
			"Nathan, I'm" = {"Text" = "Nathan, I'm sitting right next to you. You don't have to send notes to me.", "Target" = "Nathan", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "But sending"}]},
			"Whatever you" = {"Text" = "Whatever you say man...", "Target" = "Nathan", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Hey, your"}]},
			"It's because" = {"Text" = "It's because I'm cooler than you. Thats why.", "Target" = "Nathan", "Meta" = []}
		},
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Frank = {
		"VentricaID" = 5,
		"Name" = "Frank",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"RandomNotes1" = [
		{"Text" = "Larry, do you also have problems with Meredith? God I just hate her.\n\n- Frank.", "Target" = "Larry", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "( ദ്ദി ˙ᗜ˙ )"}]},
		],
		"Conversation" = {
			"Meredith, I've" = {"Text" = "Meredith, I've recently suffered a death in the family, please excuse any performance hiccups because of that.", "Target" = "Meredith", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Still not"}]},
			"I know" = {"Text" = "I know right? Was she just born a #&%^& or something? Whats her problem???", "Target" = "Larry", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "(¬_¬\")"}]},
			"Thanks Larry" = {"Text" = "Thanks Larry. Your my only true friend... ", "Target" = "Larry", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "🫂"}]}
		},
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Einstein = {
		"VentricaID" = 6,
		"Name" = "Einstein",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"RandomNotes1" = [
		{"Text" = "Hello? What is this? Einstein in the house!", "Target" = "Any", "Meta" = []},
		],
		"Conversation" = {
			"Yeah, theres" = {"Text" = "Yeah, theres a good place down the street called 'Aldi'", "Target" = "Eli", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "..."}]},
			"Yeah, it" = {"Text" = "Yeah, it was 5,000, Gertrude ate 23 cakes last month.", "Target" = "Nathan", "Meta" = []},
			"What do" = {"Text" = "What do you mean? I spent all night working on that report.", "Target" = "Gertrude", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "You calculated"}]},
			"Yeah? What" = {"Text" = "Yeah? What do you not know how interest works?",  "Target" = "Gertrude", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Why the"}]},
			"It's because" = {"Text" = "It's because im just that good at finance Gerty.",  "Target" = "Gertrude", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "YOU TOO???"}]}
		},
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Bertha = {
		"VentricaID" = 6,
		"Name" = "Bertha",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"RandomNotes1" = [
			{"Text" = "Oh my gawwwwd. Gertrude is there a new guy working in our office? Is he hot??", "Target" = "Gertrude", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "I don't"}]},
		],
		"Conversation" = {
			"Sooooo whaaaat." = {"Text" = "Sooooo whaaaat. Can't you live a little Gerty?", "Target" = "Gertrude", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Don't call"}]},
			"But don't" = {"Text" = "But don't you think he's kind of cute?", "Target" = "Gertrude", "Meta" = [{"Recipient" = "Target", "Sender" = "Bertha", "Return" = "Gerty?"}]},
			"Gerty?" = {"Text" = "Gerty?", "Target" = "Gertrude", "Meta" = [{"Recipient" = "Target", "Sender" = "Bertha", "Return" = "Gerty-poo?"}]},
			"Gerty-poo?" = {"Text" = "Gerty-poo?", "Target" = "Gertrude", "Meta" = [{"Recipient" = "Target", "Sender" = "Bertha", "Return" = "Gerty-boo?"}]},
			"Gerty-boo?" = {"Text" = "Gerty-boo?", "Target" = "Gertrude", "Meta" = []},
			"Yes! It's" = {"Text" = "Yes! It's room 1102.", "Target" = "Gertrude", "Meta" = []},
			"What are" = {"Text" = "What are you talking about Gerty, I did nothing like thaaat.", "Target" = "Gertrude", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "I SAW"}]},
			"Sorryyyy, its" = {"Text" = "Sorryyyy, its just that your face is so wrinkly.", "Target" = "Gertrude", "Meta" = []}
		},
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Gertrude = {
		"VentricaID" = 8,
		"Name" = "Gertrude",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"RandomNotes1" = [
		{"Text" = "Hey Einstein... I've noticed that all of your numbers in your recent report are wrong.", "Target" = "Einstein", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "What do"}]},
		],
		"Conversation" = {
			"I don't" = {"Text" = "I don't know bertha. I'm 40 years old. I have a husband and kids.", "Target" = "Bertha", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Sooooo whaaaat."}]},
			"Don't call" = {"Text" = "Don't call me that. Stop wasting my time.", "Target" = "Bertha", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "But don't"}]},
			"You calculated" = {"Text" = "You calculated our 2% loan for the factory as an additional 2$ on our debt...", "Target" = "Einstein", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Yeah? What"}]},
			"Why the" = {"Text" = "Why the HELL did the boss put you in charge of this.", "Target" = "Einstein", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "It's because"}]},
			"YOU TOO???" = {"Text" = "YOU TOO??? HAVE YOU AND BERTHA BEEN TALKING????", "Target" = "Einstein", "Meta" = []},
			"I SAW" = {"Text" = "I SAW YOU. I SAW YOU TAKE IT. AND STOP @&^$% CALLING ME THAT", "Target" = "Bertha", "Meta" = []},
			"YOU. I'm" = {"Text" = "#$^& YOU. I'm 40. 40 YEARS OLD. HOW DO YOU THINK IM 97.", "Target" = "Bertha", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Sorryyyy, its"}]}
		},
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Eli = {
		"VentricaID" = 9,
		"Name" = "Eli",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"Greeting" = [{"Text" = "Wassup new person. Just as a warning if you see a guy talking in emoticons its probably Larry... I had to learn the hard way.", "Target" = "Any", "Meta" = []}],
		"RandomNotes1" = [
		{"Text" = "Hey Bob, Could you come clean up this spill", "Target" = "Bob", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "On it!"}]},
		{"Text" = "Hey, does anyone know where the photocopier is?", "Target" = "Any", "Meta" = []},
		{"Text" = "Hey Einstein, do you know of any good ramen places?\n\nEli", "Target" = "Einstein", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "Yeah, theres"}]},
		],
		"Conversation" = {
			"..." = {"Text" = "...", "Target" = "Einstein", "Meta" = []}
		},
		"PerpetualNotes" = [],
		"SentNotes" = []
	},
	Boss = {
		"VentricaID" = 10,
		"Name" = "Boss",
		"Color" = "yellow",
		"SystemTrust" = 1.0,
		"PerpetualChance" = 0.0,
		"Greeting" = [{"Text" = "First of all, I would like to say hello welcome to your new job as a mailmaster at this company. Your job is to sort through the notes that come through and send them to the correct people in the office. Have a nice day and good luck!", "Target" = "Any", "Meta" = []}],
		"RandomNotes1" = [
		{"Text" = "Eli, please come to my office.", "Target" = "Eli", "Meta" = []},
		{"Text" = "Hey Larry, could you research a new employee monitoring software?", "Target" = "Larry", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "(¬_¬\"')"}]},
		],
		"Conversation" = {
			"I need" = {"Text" = "I need one with privledge settings so restrictions don't apply to everyone", "Target" = "Larry", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "(¬_¬\"'')"}]},
			"I'll get" = {"Text" = "I'll get you icecream later if you do!!!", "Target" = "Larry", "Meta" = [{"Recipient" = "Target", "Sender" = "Target", "Return" = "( ˶ˆᗜˆ˵ )"}]},
		},
		"PerpetualNotes" = [],
		"SentNotes" = []
	}
}
var hasRecievedNotes = false


func _ready() -> void:
	_on_timer_timeout()

func _on_timer_timeout() -> void:
	notesSent = 0
	
	for person in people:
		if not greetingSent and people[person].has("Greeting"):
			for greet in people[person]["Greeting"]:
				# Greetings disabled
				sendNotes(greet["Text"], people[person]["Color"], greet["Target"], people[person]["Name"], true, greet, true)
				pass
		
		for i in randomNoteSpawnRollCount:
			if people[person]["PerpetualChance"] <= 0 and people[person]["SentNotes"].size() >= people[person]["RandomNotes1"].size():
				break
			if (activeConversations >= maxConversations):
				break
			if randf() < clampf(randomNoteSpawnChancePerCycle * people[person]["SystemTrust"], 0.0, 1.0):
				var selectedNote = {"Text" = "No way brochacho", "Target" = "Trash", "Meta" = []}
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
				sendNotes(selectedNote["Text"], people[person]["Color"], selectedNote["Target"], people[person]["Name"], isPerpetual, selectedNote)
				activeConversations += 1
		
	
	greetingSent = true
	
func handleNotes(note:Note, sentWithoutCannister:bool, ventricleID):
	if not hasRecievedNotes:
		hasRecievedNotes = true
		recieveFirstNote.emit()
	var noteDict = null
	for n in currentNotes:
		if (n["Text"] == note.text):
			noteDict = n
	if noteDict == null:
		print("No notes!")
		return
	if (ventricleID != 11 and ventricleIds[ventricleID] == noteDict["Target"]) or noteDict["Target"] == "Any":
		if (noteDict["Meta"].size() > 0):
			var person
			if (noteDict["Meta"][0]["Sender"] == "Target" or noteDict["Target"] == "Any"):
				person = noteDict["Target"]
			else:
				person = noteDict["Meta"][0]["Sender"]
			sendNotes(people[person]["Conversation"][noteDict["Meta"][0]["Return"]]["Text"], people[person]["Color"], people[person]["Conversation"][noteDict["Meta"][0]["Return"]]["Target"], people[person]["Name"], false, people[person]["Conversation"][noteDict["Meta"][0]["Return"]])
		else:
			activeConversations -= 1
		currentAccuracyQuality += 1
		currentAccuracyQuality = clamp(currentAccuracyQuality, 0, 10)
	else:
		activeConversations -= 1
		activeConversations = max(activeConversations, 0)
		currentAccuracyQuality -= 1
		if (currentAccuracyQuality <= 6):
			get_tree().change_scene_to_file("res://Scenes/Menus/DeathMenu.tscn")
	$"../SubViewport/AccuracyMeter".get_child(0).accuracy_percent = (currentAccuracyQuality - 6) * 25
	
	
func sendNotes(text: String, color: String, target: String, origin: String, isPerpetual: bool, noteDict, maxNoteOverride := false,) -> void:
	if notesSent > maxNoteSpawns and not maxNoteOverride:
		return
	notesSent += 1
	spawner.printNote(text, color)
	currentNotes.append(noteDict)
	if not isPerpetual:
		people[origin]["SentNotes"].append({"Text" = text, "Target" = target})

func _ventricle_return_function(object:Node3D, ventricle:int):
	var parent = object.get_parent()
	if parent is CylenderContents and parent.hasContents:
		handleNotes(parent.contents, false, ventricle)
	if parent is Note:
		handleNotes(parent, true, ventricle)
		pass


func _on_trash_can_trigger_dropped_function(object: Node3D) -> void:
	var parent = object.get_parent()
	if parent is CylenderContents and parent.hasContents:
		handleNotes(parent.contents, false, 11)
	if parent is Note:
		handleNotes(parent, true, 11)
		pass
	object.queue_free()
