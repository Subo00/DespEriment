extends Node2D

func delete_self() -> void:
	queue_free()

func _ready() -> void:
	Signals.OnCleanUp.connect(delete_self)
