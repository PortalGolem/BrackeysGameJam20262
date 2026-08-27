extends Node

var score := 0

@onready var spawner := $CylenderSpawner
@export var randomNoteSpawnChancePerCycle := .1
@export var randomNoteSpawnRollCount := 4
@export var maxNoteSpawns := 2

var greetingSent := false

var people = {
	 Garry = {
			"VentricaID" = 0,
			"Name" = "Garry",
			"Color" = "yellow",
			"SystemTrust" = 1.0,
			"RandomNotes1" = [
			{"Text" = "Hey Zenith! Whats up?", "Target" = "Zenith"},
			{"Text" = "Terry, could you submit the report due on thursday?", "Target" = "Zenith"},
			{"Text" = "Whats going on with the coffee machine?", "Target" = "Any"},
			{"Text" = "Larry, did you finish fixing the projector?", "Target" = "Larry"}],
			"PerpetualNotes" = []},
		Terry = {
			"VentricaID" = 1,
			"Name" = "Terry",
			"Color" = "pink",
			"SystemTrust" = 1.0,
			"RandomNotes1" = [
			{"Text" = "Larry, did you turn my computer off and on again like I asked?", "Target" = "Larry"},
			{"Text" = "I'm new here, does anyone know where the board room is?", "Target" = "Any"},
			{"Text" = "Did you see the sports game last night Larry?", "Target" = "Larry"},
			{"Text" = "Zenith, did you see that episode of 'That's Just Kevin?'", "Target" = "Zenith"}],
			"PerpetualNotes" = [],
			"Greeting" = [{"Text" = "Hey there new guy! I'm also kind of new around here
			But I started out just like you in the mail room. I was only 'interim mail
			officer' whereas you're full time but hopefully I can give you some pointers."
			, "Target" = "Any"}, 
			{"Text" = "First off you can throw these notes in the trash to your right
			when you're done with them, go ahead and throw away the whole canister we
			have a million of them.", "Target" =  "Trash"},
			{"Text" = "Second, its a little hard to remember names so I left sticky notes
			on the pipes for who they go to. Everyone here (except Larry) uses one color note to
			talk to other people, so if they don't say you can usually tell", "Target" = "Trash"},
			{"Text" = "The last thing you should know is that we have a terrible label system so
			go ahead and read the notes to see who their supposed to go to. Good luck!", "Target" = "Trash"}]},
		Larry = {
			"Ventrica" = 2,
			"Name" = "Larry",
			"Color" = "rand",
			"SystemTrust" = 1.0,
			"RandomNotes1" = [],
			"PerpetualNotes" = [
			{"Text" = ":)", "Target" = "Any"}, {"Text" = "o_O", "Target" = "Any"}]},
		Zenith = {
			"VentricaID" = 3,
			"Name" = "Zenith",
			"Color" = "blue",
			"SystemTrust" = 1.0,
			"RandomNotes1" = [
			{"Text" = "PSA to Garry: Don't leave your sandles in the microwave, we eat out of that", "Target" = "Garry"},
			{"Text" = "The coffee machine has been moved to the board room.", "Target" = "Any"},
			{"Text" = "I love you Larry...", "Target" = "Any"},
			{"Text" = "Terry, could you come over to HR, I need to test out my new stand up routine", "Target" = "Terry"},
			{"Text" = "Please use the printer for only work purposes. (That means you Garry)", "Target" = "Garry"}],
			"PerpetualNotes" = [],
			"Greeting" = [{"Text" = "Hey Terry, there's a new mail person. We can send messages again!", "Target" = "Terry"}]}
}

func _ready() -> void:
	_on_timer_timeout()

func _on_timer_timeout() -> void:
	for person in people:
		print("Going through the roster: " + person["Name"])
		if person.has("Greeting"):
			print("Attepting Greet!")
			for greet in person["Greeting"]:
				print("Greeting!")
				spawner.printNote(greet["Text"], person["Color"])
	
	greetingSent = true
	
