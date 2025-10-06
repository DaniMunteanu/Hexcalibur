extends Node

var rng = RandomNumberGenerator.new()

var game_finished : bool = false

signal apply_camera_shake

signal shoot_cultist(cultist_index: int)

signal game_victory
signal game_over

signal start_new_game
signal return_to_main_menu
