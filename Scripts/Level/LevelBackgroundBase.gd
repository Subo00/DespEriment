extends Node2D

func delete_self() -> void:
	print_debug("deleted")
	queue_free()
