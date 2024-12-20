class_name NarratorManager

extends Node


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var dialog_box: DialogBox = $DialogBox

#endings 
var audio_ending = ".mp3"
var text_ending = ".txt"

#rounds
var stream_round_string = "res://Assets/Dialog/Rounds/round_"
var start_string = "_start_"
var start_stream_index = 1
var current_round = 1

var is_round_begin = true
var is_success_global = false

func _ready() -> void:
	Signals.StartNarratonEnd.connect(_play_round_end)

func _play_round_end(is_success: bool = false) -> void:
	var full_string = stream_round_string + str(current_round) 
	
	is_success_global = is_success
	start_stream_index = 1
	
	if !is_success:
		full_string += "_cd0" 
	else:
		full_string += "_success"
	
	var file = FileAccess.open(full_string + text_ending, FileAccess.READ)
	var new_stream = load(full_string + audio_ending)
	
	is_round_begin = false
	
	if new_stream:
		audio_stream_player.stream = new_stream
		audio_stream_player.play()
		
		#change the dialog
		dialog_box.display_dialog(file.get_as_text())
		
	else:
		print("no audio for round end")

func _play_round_start(value: int = current_round) -> void:
	var full_string = stream_round_string + str(value) + start_string + str(start_stream_index) 
	
	var new_stream = load(full_string + audio_ending)
	print(full_string + audio_ending)
	
	is_round_begin = true
	current_round = value
	
	
	if new_stream:
		start_stream_index += 1
		audio_stream_player.stream = new_stream
		audio_stream_player.play()
		
		#change the dialog
		var file = FileAccess.open(full_string + text_ending, FileAccess.READ)
		
		dialog_box.display_dialog(file.get_as_text())
		
	else:
		print("All round start streams finished playing")
		start_stream_index = 1
		Signals.NarratorAudioStartEnded.emit()
		


func _on_audio_stream_player_finished() -> void:
	
	await get_tree().create_timer(0.3).timeout
	dialog_box.hide_dialog()
	
	if is_round_begin:
		_play_round_start()
	else:
		Signals.NarratorAudioEndEnded.emit(is_success_global)
