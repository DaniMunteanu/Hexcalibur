extends CharacterBody2D

const SPEED = 200.0

var is_alive : bool = true

func update_movement():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	velocity = direction * SPEED
	move_and_slide()
	
func update_orientation():
	look_at(get_global_mouse_position())
	
func _physics_process(delta: float) -> void:
	if is_alive:
		update_movement()
		update_orientation()
