extends Label
@onready var gear_counter: Node = $GearCounter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#await get_tree().create_timer(2.0).timeout

	text = str(gear_counter.currentGear) + " / " + str(gear_counter.maxGear)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
