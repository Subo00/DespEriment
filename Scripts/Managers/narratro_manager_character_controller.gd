extends Node

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var dialog_box: DialogBox = $DialogBox
@onready var sprite_2d: Sprite2D = $Sprite2D

var begin_streams = [
	"res://Assets/Dialog/Begin/Begin_1",
	"res://Assets/Dialog/Begin/Begin_2",
	"res://Assets/Dialog/Begin/Begin_3",
	"res://Assets/Dialog/Begin/Begin_4",
	"res://Assets/Dialog/Begin/Begin_5",
	"res://Assets/Dialog/Begin/Begin_6",
]
var current_begin_index = 0
var audio_ending = ".mp3"
var text_ending = ".txt"

var intro_faces = [
	"res://Assets/Art/Intro/machine_surprised.png",
	"res://Assets/Art/Intro/machine_neutral.png",
	"res://Assets/Art/Intro/machine_happy.png",
	"res://Assets/Art/Intro/machine_half_lid_eye.png",
	"res://Assets/Art/Intro/machine_surprised.png",
	"res://Assets/Art/Intro/machine_judgemental.png",
]

func _ready() -> void:
	var str = "."
	for i in 6:
		dialog_box.display_dialog(str)
		await get_tree().create_timer(0.7).timeout
		str += "."
		
	_play_next_stream()
	
	
func _play_next_stream():
	if current_begin_index < begin_streams.size():
		#change the audio
		var new_stream = load(begin_streams[current_begin_index] + audio_ending)
		var file = FileAccess.open(begin_streams[current_begin_index] + text_ending, FileAccess.READ)
		
		if current_begin_index == 3 or current_begin_index == 4 or current_begin_index == 5:
			await get_tree().create_timer(2.3).timeout
		
		if new_stream:
			audio_stream_player.stream = new_stream
			audio_stream_player.play()
			
			#change the sprite
			sprite_2d.texture = load(intro_faces[current_begin_index])
			
			#change the dialog
			dialog_box.display_dialog(file.get_as_text())
		else:
			print("Error, cant load shit")
		current_begin_index += 1
	else:
		print("All streams finished playing")
		dialog_box.hide_dialog()
		#start the level1 
		get_tree().change_scene_to_file("res://Scenes/Managers/GameManager.tscn")


func _on_audio_stream_player_finished() -> void:
	
	await get_tree().create_timer(0.3).timeout
	dialog_box.hide_dialog()
	
	_play_next_stream()
