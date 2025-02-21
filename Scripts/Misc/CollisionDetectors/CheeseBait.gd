extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("nes")
	#pokreni animaciju za sir
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	print("nesto drugo")
	#stop the cheese animation
	pass # Replace with function body.
