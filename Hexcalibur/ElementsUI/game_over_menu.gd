extends Control

func _on_play_again_button_pressed() -> void:
	Global.start_new_game.emit()

func _on_exit_to_main_menu_button_pressed() -> void:
	Global.return_to_main_menu.emit()
