extends InteractableBase

@export var door_id: int = 0

func do_the_thing() -> void:
	if !is_activated:
		is_activated = !is_activated
		pop_up_e.hide()
		Signals.OnDoorToggle.emit(door_id)
