extends Control

@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var VOICE_BUS_ID = AudioServer.get_bus_index("Voice")
@onready var settings_menu: Control = $"."
@onready var voice_button: CheckButton = $MarginContainer/VBoxContainer/GridContainer/VoiceButton
@onready var blind_button: CheckButton = $MarginContainer/VBoxContainer/GridContainer/BlindButton

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var dialog_box: DialogBox = $DialogBox


func _ready() -> void:
	dialog_box.hide_dialog()
	Signals.Pause.connect(show_settings)
	return

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		settings_menu.visible = !settings_menu.visible
	

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < 0.05)



func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)

func show_settings(is_pause: bool) -> void:
	settings_menu.visible = !settings_menu.visible

func _on_voice_button_pressed() -> void:
	voice_button.disabled = true
	dialog_box.display_dialog("Wait, you think you can shut me up?")
	audio_stream_player.play()
	await get_tree().create_timer(2.6).timeout
	dialog_box.hide_dialog()
	voice_button.button_pressed = true
	voice_button.disabled = false
