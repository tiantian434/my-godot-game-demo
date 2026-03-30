extends CanvasLayer



func _on_button_new_game_pressed() -> void:
	GameManager.GoToNextLevel()


func _on_button_quit_pressed() -> void:
	get_tree().quit()
