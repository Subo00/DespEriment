extends Control

@onready var settings_menu: Control = $Settings
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var v_box_container_settings: VBoxContainer = $VBoxContainer2


func _on_options_button_pressed() -> void:
	settings_menu.visible = true
	v_box_container.visible = false


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_back_button_pressed() -> void:
	settings_menu.visible = false
	v_box_container.visible = true


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu/CharacterCreation.tscn")
