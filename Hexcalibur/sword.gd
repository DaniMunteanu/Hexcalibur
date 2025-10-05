extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var power_level : int = 1

func upgrade():
	if power_level < 6:
		power_level += 1

func _on_hitbox_area_entered(hurtbox: Hurtbox) -> void:
	hurtbox.take_damage(power_level)
	
func attack():
	animation_player.play("Attack" + str(power_level))
	
func stop_attacking():
	animation_player.play("RESET")
