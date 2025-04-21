extends Node2D

@onready var pivot: Node2D = $"../Flower"
const FIRE = preload("res://scenes/fire.tscn")

var f_angle := 0.0
var b_playing := false
var f_distance = 100
var i_difficulty := 0

var f_shootdelaytime := 2.0
var f_shoottime := 0.0
var i_distanceDir := -1

func _ready() -> void:
	Setup(0)

func Setup(lv: int):
	i_difficulty = lv
	f_distance = 260
	f_angle = PI
	position = pivot.position + Vector2(sin(f_angle),cos(f_angle)) * f_distance
	look_at(pivot.position)
	print("dificultad: ", lv)

func _process(delta: float) -> void:
	if !b_playing:
		return
	
	f_distance = position.distance_to(pivot.position)
	f_angle += delta * 0.5
	look_at(pivot.position)
	Controler(delta)
	position = pivot.position + Vector2(sin(f_angle),cos(f_angle)) * f_distance
	
	if f_distance > 400 && i_difficulty == 4:
		print("WIN")
		$"..".LastWin()


func ShootFireBall():
	var b = FIRE.instantiate()
	b.name = "Fire"
	$"../BulletPool".add_child(b)
	b.transform = transform
	b.rotation += $Sprite2D.rotation

func ShootDoubleFireBall():
	var b1 = FIRE.instantiate()
	var b2 = FIRE.instantiate()
	$"../BulletPool".add_child(b1)
	$"../BulletPool".add_child(b2)
	b1.SetColor("#ffb130") 
	b2.SetColor("#ffb130") 
	b1.transform = transform
	b2.transform = transform
	b1.rotation += $Sprite2D.rotation + .3
	b2.rotation += $Sprite2D.rotation - .3
	b1.f_delay = 1
	b2.f_delay = 1

func ShootSpacedFireBall():
	var b1 = FIRE.instantiate()
	var b2 = FIRE.instantiate()
	$"../BulletPool".add_child(b1)
	$"../BulletPool".add_child(b2)
	b1.transform = transform
	b2.transform = transform
	b1.rotation += $Sprite2D.rotation
	b2.rotation += $Sprite2D.rotation
	b1.f_delay = 0.5
	b2.f_delay = 1.5
	b1.SetColor("#953c8b") 
	b2.SetColor("#953c8b") 

func Controler(delta):
	
	f_shoottime += delta
	#disparo normal
	if f_shoottime > f_shootdelaytime:
		if i_difficulty == 1:
			ShootFireBall()
		elif i_difficulty == 2:
			var i = randi_range(0, 1)
			if i == 0: ShootFireBall()
			if i == 1: ShootDoubleFireBall()
		elif i_difficulty >= 3:
			var i = randi_range(0, 2)
			if i == 0: ShootFireBall()
			if i == 1: ShootDoubleFireBall()
			if i == 2: ShootSpacedFireBall()
		f_shoottime = 0
	
	#----------------------------------------------------
	
	#viene y va
	if i_difficulty == 3:
		if i_distanceDir == -1:
			f_distance -= delta
			if f_distance < 200:
				i_distanceDir = 1
		elif i_distanceDir == 1:
			f_distance += delta
			if f_distance > 300:
				i_distanceDir = -1
		f_distance += delta * 4 * i_distanceDir
	
	if i_difficulty == 4:
		if f_distance > 200: 
			f_distance -= delta * 4
		if f_distance > 400:
			f_distance -= delta * 4
			$"..".DragonDie()
	elif i_difficulty == 3:
		if f_distance > 200:
			f_distance -= delta * 20
	
	if f_distance < 200:
		f_distance = 200

func _on_dragon_animator_animation_finished(anim_name: StringName) -> void:
	$DragonAnimator.play(anim_name)

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	f_distance += 40
	if f_distance > 340 && i_difficulty != 4:
		return
	position = pivot.position + Vector2(sin(f_angle),cos(f_angle)) * f_distance
