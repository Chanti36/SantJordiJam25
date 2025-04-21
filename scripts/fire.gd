extends RigidBody2D

var f_timer := 0.0
var f_delay := 0.0
var i_speed := 100

func _ready() -> void:
	f_timer = 0.0

func SetColor(newcolor: StringName):
	$Sprite2D.modulate = Color.html(newcolor)

func _physics_process(delta):
	if f_delay > 0.0:
		f_delay -= delta
		return
	
	f_timer +=delta
	if f_timer > 20:
		queue_free()
	position += transform.y * i_speed * delta

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer.play(anim_name)


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	queue_free()
