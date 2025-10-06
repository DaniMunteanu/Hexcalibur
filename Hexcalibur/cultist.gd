extends CharacterBody2D

@onready var health: Health = $Health
@onready var cultist_hp_bar: TextureProgressBar = $CultistHPBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func init_health_bar():
	cultist_hp_bar.max_value = health.max_health
	cultist_hp_bar.value = health.current_health
	
func _update_health_bar(diff: int):
	cultist_hp_bar.value = health.current_health
	animation_player.play("Hit")
	
func _ready() -> void:
	init_health_bar()
	health.health_changed.connect(_update_health_bar)

func _on_health_health_depleted() -> void:
	Global.game_over.emit()
