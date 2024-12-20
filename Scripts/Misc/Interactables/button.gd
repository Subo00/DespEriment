extends InteractableBase
@onready var pressed: Sprite2D = $Pressed


func _on_area_2d_body_entered(body: Node2D) -> void:
	Signals.OnInteracted.emit()
	sprite_2d.hide()
	pressed.show()
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	sprite_2d.show()
	pressed.hide()
