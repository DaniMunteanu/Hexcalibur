extends CharacterBody2D

@onready var sword: Node2D = $Sword
@onready var respawn_point = get_parent().get_node("RespawnPoint")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health: Health = $Health
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var invincibility_timer: Timer = $InvincibilityTimer

const SPEED = 200.0

var is_alive : bool = true

func update_movement():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	velocity = direction * SPEED
	move_and_slide()
	
func update_orientation():
	look_at(get_global_mouse_position())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack") && is_alive:
		sword.attack()
	if event.is_action_released("attack"):
		sword.stop_attacking()

func respawn():
	global_position = respawn_point.global_position
	health.current_health = 1
	is_alive = true
	animation_player.play("Hit")

func _physics_process(delta: float) -> void:
	if is_alive:
		update_movement()
		update_orientation()

func _on_health_health_depleted() -> void:
	hurtbox.set_collision_layer_value(3,false)
	invincibility_timer.start()
	
	is_alive = false
	sword.stop_attacking()
	sword.upgrade()
	respawn()

func _on_invincibility_timer_timeout() -> void:
	hurtbox.set_collision_layer_value(3,true)
