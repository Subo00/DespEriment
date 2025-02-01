class_name GearCounter
extends Node

#To use add it to the LevelVariation you created
#Then add Gears as its children


var maxGear = 0
var currentGear = 0

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
