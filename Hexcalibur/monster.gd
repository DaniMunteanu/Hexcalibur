extends CharacterBody2D

@onready var player = get_parent().get_node("Player")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var health: Health = $Health
@onready var monster_hp_bar: TextureProgressBar = $MonsterHPBar
@onready var invincibility_timer: Timer = $InvincibilityTimer
@onready var attack_timer: Timer = $AttackTimer

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
	
func init_health_bar():
	monster_hp_bar.max_value = health.max_health
	monster_hp_bar.value = health.current_health
	
	monster_hp_bar.get_node("MonsterHPBarSecondary").max_value = health.max_health
	monster_hp_bar.get_node("MonsterHPBarSecondary").value = health.current_health
	
func _update_health_bar(diff: int):
	hurtbox.set_collision_layer_value(3,false)
	invincibility_timer.start()
	
	monster_hp_bar.value = health.current_health
	
	await get_tree().create_timer(0.5).timeout
	monster_hp_bar.get_node("MonsterHPBarSecondary").value = health.current_health

func start_attack_timer():
	attack_timer.start()

func _ready() -> void:
	init_health_bar()
	health.health_changed.connect(_update_health_bar)
	
func _physics_process(delta: float) -> void:
	follow_player()

func _on_hitbox_area_entered(hurtbox: Hurtbox) -> void:
	hurtbox.take_damage(5)

func _on_invincibility_timer_timeout() -> void:
	hurtbox.set_collision_layer_value(3,true)
	
func _on_attack_timer_timeout() -> void:
	melee_attack()
