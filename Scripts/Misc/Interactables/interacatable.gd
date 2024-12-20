class_name InteractableBase
extends Node2D

@onready var pop_up_e: TextureRect = $popUpE
@onready var sprite_2d: Sprite2D = $Sprite2D

var is_activated = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pop_up_e.hide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	pop_up_e.show()
	Signals.OnInteraction.connect(do_the_thing)


func _on_area_2d_body_exited(body: Node2D) -> void:
	pop_up_e.hide()
	Signals.OnInteraction.disconnect(do_the_thing)


func do_the_thing() -> void:
	is_activated = !is_activated
	sprite_2d.flip_v = is_activated
	
	if is_activated:
		Signals.OnInteracted.emit()
