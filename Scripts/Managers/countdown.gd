extends Node2D

@onready var timer: Timer = $Timer
@export var time_to_set: float = 10

func _ready() -> void:
	Signals.OnLevelStart.connect(reset_timer)
	Signals.Pause.connect(pause)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.set_text(str(time_to_minutes_secs_mili(timer.get_time_left())))

func time_to_minutes_secs_mili(time : float):
	var mins = int(time) / 60
	time -= mins * 60
	var secs = int(time)
	var mili = int((time - int(time)) * 100)
	return str("%0*d" % [2, mins]) + ":" + str("%0*d" % [2, secs]) + ":" + str("%0*d" % [2, mili]) 

func _on_timer_timeout() -> void:
	Signals.StartNarratonEnd.emit(false)

func reset_timer() -> void:
	timer.wait_time = time_to_set
	timer.one_shot = true
	timer.start()


func set_timer(time: float) -> void:
	timer.wait_time = time
	
func pause(is_pause: bool) -> void:
	timer.set_paused(is_pause)
