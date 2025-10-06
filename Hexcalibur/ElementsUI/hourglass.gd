extends Control

@onready var texture_progress_bar_top: TextureProgressBar = $TextureProgressBarTop
@onready var texture_progress_bar_bottom: TextureProgressBar = $TextureProgressBarBottom
@onready var timer: Timer = $Timer

func _ready() -> void:
	reset()
	Global.game_victory.connect(_on_game_victory)
	timer.start()

func _physics_process(delta: float) -> void:
	texture_progress_bar_top.value = timer.time_left
	
	texture_progress_bar_bottom.value = timer.wait_time - timer.time_left

func reset():
	texture_progress_bar_top.max_value = timer.wait_time
	texture_progress_bar_top.value = timer.wait_time
	
	texture_progress_bar_bottom.max_value = timer.wait_time
	texture_progress_bar_bottom.value = 0

func _on_game_victory():
	timer.stop()

func _on_timer_timeout() -> void:
	Global.game_over.emit()
