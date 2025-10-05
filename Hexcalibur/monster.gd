extends CharacterBody2D

@onready var player = get_parent().get_node("Player")

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Hitbox = $Hitbox

var locked_in : bool = false

func lock_in():
	locked_in = true
	
func lock_out():
	locked_in = false
	
func follow_player():
	if locked_in == false:
		rotation_degrees = rad_to_deg(global_position.angle_to_point(player.global_position)) - 30
	
func melee_attack():
	animation_player.play("MeleeAttack")
	
func _ready() -> void:
	await get_tree().create_timer(5).timeout
	melee_attack()
	
func _physics_process(delta: float) -> void:
	follow_player()

func _on_hitbox_area_entered(hurtbox: Hurtbox) -> void:
	hurtbox.take_damage(5)
