extends AnimatedSprite2D

func _process(_delta: float) -> void:
	if frame_progress == 1:
		queue_free()
