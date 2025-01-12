class_name GameManger

extends Node2D

@onready var narratro_manager: NarratorManager = $CameraStuff/ProCam2D/NarratorManager
@onready var player: CharacterBody2D = $Player

#for level loading
var prefix = "res://Scenes/Levels/LevelVariations/Level"
var sufix = ".tscn"

var variation_count = 1

var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.NarratorAudioEndEnded.connect(handle_ending)
	load_level_variation(variation_count)
	
	#await get_tree().create_timer(2.0).timeout
	
func _physics_process(delta: float) -> void:
	if (Input.is_action_pressed("pause")):
		is_paused = !is_paused
		Signals.Pause.emit(is_paused)

func load_level_variation(level: int) -> void:
	var string_path = prefix + str(level) + sufix
	var level_resource = load(string_path)
	var level_variation = level_resource.instantiate()  as Node2D
	add_child(level_variation)
	
	#TODO:add a check if the level can be loaded 
	
	narratro_manager._play_round_start(level)
	player.reset_position()
	Signals.OnLevelStart.emit()
	Signals.ChangeGearUI.emit("")

	
func handle_ending(is_success: bool) -> void:
	if !is_success and variation_count == 1:
		return
	
	Signals.OnCleanUp.emit()
	
	if !is_success:
		load_level_variation(variation_count)
		return
	
	variation_count += 1
	load_level_variation(variation_count)
