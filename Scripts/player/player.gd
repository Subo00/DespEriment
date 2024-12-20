extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -450.0

var pause = false
var player_pos = Vector2()
var can_interact = false

@onready var jumpSFX: AudioStreamPlayer2D = $JumpSFX
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
#comment
var inFuseBox = false
var inLever = false
#@onready var lever_animation_player: AnimationPlayer = $"../interactables/LeverArea/lever/AnimationPlayer"
var inLeverWall = false
##@onready var lever_wall_animation_player: AnimationPlayer = $"../interactables/LeverAreaWall/lever_wall/AnimationPlayer"
#@onready var direction: Marker2D = $direction

#postion of the player to be set


func _ready() -> void:
	player_pos = position
	Signals.Pause.connect(set_pause)

func reset_position() -> void:
	position = player_pos

func _physics_process(delta: float) -> void:
	if pause:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("interact"):
		Signals.OnInteraction.emit()
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumpSFX.play()
		velocity.y = JUMP_VELOCITY
	
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	#flip sprite
	if direction > 0:
		animated_sprite.flip_h = true
	if direction < 0:
		animated_sprite.flip_h = false
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func set_pause(is_pause: bool) -> void:
	pause = is_pause
