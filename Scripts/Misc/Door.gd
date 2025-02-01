extends Node2D
#Open and Closed Nodes
@onready var door_closed: Node2D = $DoorClosed
@onready var door_opened: Node2D = $DoorOpened
@onready var collision_shape_2d: CollisionShape2D = $DoorClosed/StaticBody2D/CollisionShape2D

#Exposed variables for designers
@export var door_id: int = 0
@export var opend_once: bool = true
var opend = false

func _ready() -> void:
	Signals.OnDoorToggle.connect(toggle_door)

func _open() -> void:
	door_closed.hide()
	door_opened.show()
	opend = true
	collision_shape_2d.set_disabled(true)  
	pass

func _close() -> void:
	door_closed.show()
	door_opened.hide()
	opend = false
	collision_shape_2d.set_disabled(false)   
	pass

func toggle_door(id: int) -> void:
	if door_id != id:
		return
	
	if !opend:
		_open()
	
	if opend && !opend_once:
		_close()
