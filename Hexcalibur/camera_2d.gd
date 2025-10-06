extends Camera2D

var random_strength: float = 10.0
var shake_fade: float = 5.0
var shake_strength: float = 0.0

func _on_apply_camera_shake():
	shake_strength = random_strength

func _ready() -> void:
	Global.apply_camera_shake.connect(_on_apply_camera_shake)

func _process(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shake_fade * delta)
		
		offset = random_offset()
		
func random_offset() -> Vector2:
	return Vector2(Global.rng.randf_range(-shake_strength,shake_strength), Global.rng.randf_range(-shake_strength,shake_strength))
