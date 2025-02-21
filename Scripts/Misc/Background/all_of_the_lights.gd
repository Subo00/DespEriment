extends Node2D

var children

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	children = get_children()
	Signals.OnInteracted.connect(_turn_on_random)
	Signals.OnCleanUp.connect(_turn_off_all)
	pass # Replace with function body.


func _turn_on_random() -> void:
	var rng = RandomNumberGenerator.new()
	
	if rng.randi_range(0,1) == 0:
		children[rng.randi_range(0, 7)]._turn_on()
	else:
		children[rng.randi_range(0, 7)]._set_blinking(true)
		

func _turn_off_all() -> void:
	for child in children:
		child._turn_of()
