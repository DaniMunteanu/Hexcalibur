extends CharacterBody2D

@onready var player = get_parent().get_node("Player")
@onready var monster_eye: Marker2D = $MonsterEye

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var locked_in : bool = false

func lock_in():
	locked_in = true
	
func lock_out():
	locked_in = false
	
func follow_player():
	if locked_in == false:
		
		look_at(player.monster_pivot.global_position)
		
func melee_attack():
	animation_player.play("MeleeAttack")
	
func _ready() -> void:
	await get_tree().create_timer(5).timeout
	melee_attack()
	
func _physics_process(delta: float) -> void:
	follow_player()
	
