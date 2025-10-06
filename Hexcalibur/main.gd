extends Node2D

@onready var MAIN_MENU = preload("res://ElementsUI/MainMenu.tscn")
@onready var LEVEL = preload("res://Level.tscn")
@onready var VICTORY_MENU = preload("res://ElementsUI/VictoryMenu.tscn")
@onready var GAME_OVER_MENU = preload("res://ElementsUI/GameOverMenu.tscn")

var current_main_menu
var current_level
var current_victory_menu
var current_game_over_menu

func _ready() -> void:
	open_main_menu()
	Global.start_new_game.connect(_on_new_game)
	Global.game_victory.connect(_on_game_victory)
	Global.return_to_main_menu.connect(_on_return_to_main_menu)
	Global.game_over.connect(_on_game_over)

func open_main_menu():
	current_main_menu = MAIN_MENU.instantiate()
	add_child(current_main_menu)

func start_new_level():
	TransitionScreen.transition_black()
	await TransitionScreen.on_transition_finished
	
	if current_level != null:
		current_level.queue_free()
		current_level = null
	
	Global.game_finished = false
	
	current_level = LEVEL.instantiate()
	add_child(current_level)
	
	if current_main_menu != null:
		current_main_menu.queue_free()
		current_main_menu = null
	elif current_victory_menu != null:
		current_victory_menu.queue_free()
		current_victory_menu = null
	elif current_game_over_menu != null:
		current_game_over_menu.queue_free()
		current_game_over_menu = null
	
	TransitionScreen.ready_for_fade_out.emit()

func _on_new_game():
	start_new_level()
	
func _on_delete_current_game():
	current_level.queue_free()
	current_level = null
	
func _on_game_victory():
	Global.game_finished = true
	
	TransitionScreen.transition_black()
	await TransitionScreen.on_transition_finished
	_on_delete_current_game()
	
	current_victory_menu = VICTORY_MENU.instantiate()
	add_child(current_victory_menu)
	TransitionScreen.ready_for_fade_out.emit()
	
func _on_game_over():
	Global.game_finished = true
	
	TransitionScreen.transition_black()
	await TransitionScreen.on_transition_finished
	_on_delete_current_game()
	
	current_game_over_menu = GAME_OVER_MENU.instantiate()
	add_child(current_game_over_menu)
	TransitionScreen.ready_for_fade_out.emit()
	
func _on_return_to_main_menu():
	TransitionScreen.transition_black()
	await TransitionScreen.on_transition_finished
	
	if current_level != null:
		current_level.queue_free()
		current_level = null
		
	current_main_menu = MAIN_MENU.instantiate()
	add_child(current_main_menu)
	
	if current_victory_menu != null:
		current_victory_menu.queue_free()
		current_victory_menu = null
		
	if current_game_over_menu != null:
		current_game_over_menu.queue_free()
		current_game_over_menu = null
	
	TransitionScreen.ready_for_fade_out.emit()
