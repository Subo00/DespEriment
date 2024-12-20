class_name DialogBox
extends PanelContainer


@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel



func display_dialog(dialog: String) -> void:
	self.visible = true
	rich_text_label.text = "COMPUTER: " + dialog

func hide_dialog() -> void:
	self.visible = false
