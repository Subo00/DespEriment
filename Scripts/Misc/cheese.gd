extends Node2D



func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	Signals.StartNarratonEnd.emit(true)
	await get_tree().create_timer(0.1).timeout
	queue_free()
