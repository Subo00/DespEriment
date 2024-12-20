extends Node

@export var maxGear = 0
var currentGear = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.OnGearCollect.connect(increment_gear)
	maxGear = get_child_count()
	
	await get_tree().create_timer(0.3).timeout

	Signals.ChangeGearUI.emit(str(currentGear) + "/" + str(maxGear))


func increment_gear() -> void:
	currentGear += 1
	Signals.ChangeGearUI.emit(str(currentGear) + "/" + str(maxGear))
	
	if currentGear == maxGear:
		Signals.StartNarratonEnd.emit(true)
