extends Control

@export var accuracy_percent = 50.0
var current_accuracy_percent = accuracy_percent
var _full_bar = 0.00

var Colors = [Color.RED, Color.ORANGE_RED, Color.DARK_ORANGE, Color.YELLOW, Color.GREEN]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_full_bar = $OutlineBar.size.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tween_bar()
	_set_color_bar()
	
	# percentage text val
	$"written text".text = str(int(accuracy_percent)) 
	pass

func _set_color_bar():
	$OutlineBar/FillBar.size.y = _full_bar * (current_accuracy_percent/100)
	if current_accuracy_percent >= 0:
		$OutlineBar/FillBar.color = Colors[0]
	if current_accuracy_percent >= 20:
		$OutlineBar/FillBar.color = Colors[1]
	if current_accuracy_percent >= 40:
		$OutlineBar/FillBar.color = Colors[2]
	if current_accuracy_percent >= 60:
		$OutlineBar/FillBar.color = Colors[3]
	if current_accuracy_percent >= 80:
		$OutlineBar/FillBar.color = Colors[4]

func tween_bar():
	if current_accuracy_percent != accuracy_percent:
		var _difference = current_accuracy_percent - accuracy_percent # 30 - 20 = 10
		var _addition = 0.001 + abs(_difference)/200 # +0.15
		if current_accuracy_percent + _addition < accuracy_percent: #  
			current_accuracy_percent += _addition
		if current_accuracy_percent + _addition > accuracy_percent: #  
			current_accuracy_percent -= _addition
		
		var _magnet_radius = 0.001
		if (current_accuracy_percent < accuracy_percent + _magnet_radius and current_accuracy_percent > accuracy_percent) or (current_accuracy_percent > accuracy_percent - _magnet_radius and current_accuracy_percent < accuracy_percent) or current_accuracy_percent == accuracy_percent:
			current_accuracy_percent = accuracy_percent
