extends InteractableBase

@onready var working: Sprite2D = $Working

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !is_activated:
		pop_up_e.show()
	Signals.OnInteraction.connect(do_the_thing)


func _on_area_2d_body_exited(body: Node2D) -> void:
	pop_up_e.hide()
	Signals.OnInteraction.disconnect(do_the_thing)


func do_the_thing() -> void:
	if !is_activated:
		is_activated = !is_activated
		sprite_2d.hide()
		working.show()
		pop_up_e.hide()
		Signals.OnInteracted.emit()
