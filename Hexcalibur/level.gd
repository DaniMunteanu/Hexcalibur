extends Node2D

const PROJECTILE = preload("res://MonsterProjectile.tscn")

@onready var shooting_points: Node2D = $ShootingPoints
@onready var cultists: Node2D = $Cultists

var shooting_points_array: Array
var cultists_array: Array

func on_shoot_cultist(cultist_index : int):
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = shooting_points_array[cultist_index-1].global_position
	new_projectile.look_at(cultists_array[cultist_index-1].global_position)
	new_projectile.direction = new_projectile.global_position.direction_to(cultists_array[cultist_index-1].global_position).normalized()
	add_child(new_projectile)

func _ready() -> void:
	Global.shoot_cultist.connect(on_shoot_cultist)
	shooting_points_array = shooting_points.get_children()
	cultists_array = cultists.get_children()
