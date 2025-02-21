class_name Collectable
extends Node2D

@onready var collect_sfx: AudioStreamPlayer2D = $collectSFX


func _on_area_2d_body_entered(body: Node2D) -> void:
	Signals.OnGearCollect.emit()
	collect_sfx.play()
	await get_tree().create_timer(0.05).timeout
	queue_free()
