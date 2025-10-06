extends Control

func _on_play_game_button_pressed() -> void:
	Global.start_new_game.emit()

func _on_exit_game_button_pressed() -> void:
	get_tree().quit()
