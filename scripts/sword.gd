extends RigidBody2D

var i_speed := 300
var f_timer := 0.0

func _ready() -> void:
	f_timer = 0.0

func _physics_process(delta):
	f_timer += delta
	if f_timer > 20:
		queue_free()
	position -= transform.y * i_speed * delta

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer.play(anim_name)
