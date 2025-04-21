extends Node2D

@onready var pivot: Node2D = $"../Flower"
@onready var player_animation: AnimationPlayer = $PlayerAnimation
const SWORD = preload("res://scenes/sword.tscn")

const i_spd = 5
var b_playing := false
var i_lives := 3

var i_dir := 0
var f_angle := 0.0
var f_distance = 150
var i_moving := 0

var f_shootCooldown := 0.5
var f_shootTimer := 0.0

func _ready() -> void:
	Setup()

func Setup():
	f_distance = 80
	f_angle = 2 * PI * f_distance
	position = rotated_point(f_angle, f_distance)
	look_at(pivot.position)
	i_moving = 0
	player_animation.play("playerIdle")

func _physics_process(delta: float) -> void:
	if !b_playing:
		return

	get_input(delta)

	var distance = position.distance_to(pivot.position)
	f_angle += delta * 0.5 * i_dir * i_spd
	position = rotated_point(f_angle, distance)
	look_at(pivot.position)

func rotated_point(_angle, _distance):
	return pivot.position + Vector2(sin(_angle),cos(_angle)) * _distance

func get_input(delta: float):
	i_dir = int(Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").x)
	f_shootTimer += delta
	if i_moving == 0 && i_dir != 0:
		player_animation.play("playerWalk")
		i_moving = 1
	elif i_moving == 1 && i_dir == 0:
		player_animation.play("playerIdle")
		i_moving = 0
	if Input.is_action_just_pressed("shoot") || Input.is_key_pressed(KEY_X):
		if f_shootTimer > f_shootCooldown:
			ShootSword()
			f_shootTimer = 0.0


func ShootSword():
	var b = SWORD.instantiate()
	$"../BulletPool".add_child(b)
	b.transform = transform
	b.rotation += $Sprite2D.rotation



func _on_player_animation_animation_finished(anim_name: StringName) -> void:
	player_animation.play(anim_name)


func _on_area_2d_body_entered(body: Node2D) -> void:
	#layers only detect fire
	body.queue_free()
	i_lives -= 1
	$"../../UI".ChangeHearts(-1)
	if i_lives < 1:
		i_lives = 0
		print("GAMEOVER")
		$"..".GameOver()
