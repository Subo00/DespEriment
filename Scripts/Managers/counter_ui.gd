extends Control

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.ChangeGearUI.connect(set_label)
	set_label("")
	pass # Replace with function body.


func set_label(text: String) -> void:
	if text.is_empty():
		label.text = ""
		texture_rect.hide()
	else:
		label.text = text
		texture_rect.show()
	
