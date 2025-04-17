extends Node2D

@onready var flower: Sprite2D = $Flower

const spr_flower1 = preload("res://icon.svg")
const spr_flower2 = preload("res://icon.svg")
const spr_flower3 = preload("res://icon.svg")
const spr_flower4_1 = preload("res://icon.svg")
const spr_flower4_2 = preload("res://icon.svg")

var b_onGameplay := false

var f_flowerTimer := 0.0
var i_lv = 0

func StartGameplay(level: int):
	i_lv = level
	b_onGameplay = true
	#activate player and enemy spawn

func _process(delta: float) -> void:
	if !b_onGameplay:
		return
	f_flowerTimer += delta
	
	
