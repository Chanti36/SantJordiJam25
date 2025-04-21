extends Node2D

@onready var ui: Control = $"../UI"
@onready var player: Node2D = $Player
@onready var dragon: Node2D = $Dragon

var b_onGameplay := false
var i_lv = 0

#roses
var i_flowerLv := 1
var f_flowerTimer := 0.0
var f_flowerTimes := [0.0, 0.0, 0.0]
const f_flowerTimes1 := [1.0, 2.0, 3.0, 4.0]
const f_flowerTimes2 := [3.0, 5.0, 7.0, 9.0]
const f_flowerTimes3 := [5.0, 5.0, 10.0, 10.0]

const startLerpColor := Color.BLACK
const BG_1 = preload("res://sprites/game/bg1.tres")
const BG_2 = preload("res://sprites/game/bg2.tres")
const BG_3 = preload("res://sprites/game/bg3.tres")


func SetUpGameplay(level:int):
	i_lv = level
	i_flowerLv = 1
	$Flower/FlowerAnimator.play("state1")
	$Flower/Sprite2D.self_modulate = Color.GREEN
	$CharHead.self_modulate = Color.WHITE 
	$CharHead.self_modulate.a = 0
	f_flowerTimer = 0.0
	
	if   level == 1: f_flowerTimes = f_flowerTimes1; $CharHead.texture = BG_1
	elif level == 2: f_flowerTimes = f_flowerTimes2; $CharHead.texture = BG_2
	elif level == 3: f_flowerTimes = f_flowerTimes3; $CharHead.texture = BG_3
	elif level == 4: $Flower.visible = false
	
	dragon.position = Vector2(464, 90)
	dragon.Setup(i_lv)

func StartGameplay():
	b_onGameplay = true
	player.b_playing = true
	dragon.b_playing = true
	if i_lv == 1: dragon.ShootFireBall()
	if i_lv == 2: dragon.ShootDoubleFireBall()
	if i_lv == 3: dragon.ShootSpacedFireBall()
	#4 debug
	#if i_lv != 4:
		#EndGameplay()
	#else:
		#$EndingAnimator.play("ending")
		#b_onGameplay = false
		#player.b_playing = false
		#dragon.b_playing = false
		#player.player_animation.play("playerIdle")
		#dragon.f_shoottime = 0.0

func EndGameplay(gameover := false):
	b_onGameplay = false
	player.b_playing = false
	dragon.b_playing = false
	player.player_animation.play("playerIdle")
	dragon.f_shoottime = 0.0
	
	if gameover:
		ui.Do_Transition(-1)
		return
	
	if i_lv != 4:
		ui.Do_Transition(1)
		if i_lv == 1: $"../UI/InterfaceRight/LabelRoses".text = "x 1"
		if i_lv == 2: $"../UI/InterfaceRight/LabelRoses".text = "x 2"
		if i_lv == 3: $"../UI/InterfaceRight/LabelRoses".text = "x 3"
	else:
		ui.Do_Transition(2)

func LastWin():
		$EndingAnimator.play("ending")
		b_onGameplay = false
		player.b_playing = false
		dragon.b_playing = false
		player.player_animation.play("playerIdle")
		dragon.f_shoottime = 0.0


func GameOver():
	EndGameplay(true)

func _process(delta: float) -> void:
	if !b_onGameplay:
		return
	
	ProgressManagement(delta)
	HeadManagement()
	

func ProgressManagement(delta: float):
	if i_lv == 4:
		return
	#flowers
	f_flowerTimer += delta
	if f_flowerTimer > f_flowerTimes[i_flowerLv - 1]:
		FlowerChangeState(1)

func DragonDie():
	if $Dragon.position.y > 1:
		$EndingAnimator.play("ending")
		b_onGameplay = false
		player.b_playing = false
		dragon.b_playing = false
		for n in $BulletPool.get_children():
			$BulletPool.remove_child(n)
			n.queue_free()

func _on_ending_animation_finished(_anim_name: StringName) -> void:
	EndGameplay()

func HeadManagement():
	if i_lv == 4:
		return
	
	if i_flowerLv == 1:
		$CharHead.self_modulate.a = (f_flowerTimer / f_flowerTimes[0]) * 0.12
	elif i_flowerLv == 2:
		$CharHead.self_modulate.a = 0.12 + (f_flowerTimer / f_flowerTimes[1]) * 0.13
	elif i_flowerLv == 3:
		$CharHead.self_modulate.a = 0.25 + (f_flowerTimer / f_flowerTimes[2]) * 0.75
	else:
		$CharHead.self_modulate.a = 1

#region rose

func _on_flower_animation_finished(anim_name: StringName) -> void:
	$Flower/FlowerAnimator.play(anim_name)

func _on_body_entered_rose(body: Node2D) -> void:
	body.queue_free()
	FlowerChangeState(-1)

func FlowerChangeState(change: int):
	f_flowerTimer = 0.0
	
	if change == -1:
		if i_flowerLv == 1:
			return
		i_flowerLv -= 1
		if i_flowerLv == 1: $Flower/FlowerAnimator.play("state1");
		if i_flowerLv == 2: $Flower/FlowerAnimator.play("state2");
		if i_flowerLv == 3: $Flower/FlowerAnimator.play("state3"); $Flower/Sprite2D.self_modulate = Color.GREEN
	
	if change == 1:
		if i_flowerLv == 4:
			i_flowerLv += 1
			EndGameplay()
			$CharHead.self_modulate = Color.AQUA
			for n in $BulletPool.get_children():
				$BulletPool.remove_child(n)
				n.queue_free()
			return
		i_flowerLv += 1
		if i_flowerLv == 2: $Flower/FlowerAnimator.play("state2");
		if i_flowerLv == 3: $Flower/FlowerAnimator.play("state3"); 
		if i_flowerLv == 4: $Flower/FlowerAnimator.play("state4"); $Flower/Sprite2D.self_modulate = Color.CRIMSON

#endregion
