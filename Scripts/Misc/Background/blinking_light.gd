extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
const LIGHT_OFF = preload("res://Assets/Art/levelArt/level_design_interactables/light_off.png")
const LIGHT_ON = preload("res://Assets/Art/levelArt/level_design_interactables/light_on.png")

var blinking = false
var is_turned_on = false
var interval = 0.7
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _set_blinking(blink: bool) -> void:
	blinking = blink

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !blinking:
		return
		
	counter += delta
	if counter >= interval:
		counter = 0
		
		if !is_turned_on:
			_turn_on()
		else:
			_turn_of()
		

func _turn_on():
	sprite_2d.texture = LIGHT_ON
	is_turned_on = true

func _turn_of():
	sprite_2d.texture = LIGHT_OFF
	is_turned_on = false
