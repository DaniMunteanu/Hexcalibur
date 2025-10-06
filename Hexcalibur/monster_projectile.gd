extends Node2D

var shot_speed : int = 40
var direction : Vector2

func _on_hitbox_area_entered(hurtbox: Hurtbox) -> void:
	hurtbox.take_damage(1)
	queue_free()

func _physics_process(delta):
	global_position += direction * delta * shot_speed
