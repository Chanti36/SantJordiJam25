extends Control

@onready var game: Node2D = $".."
@onready var animator: AnimationPlayer = $TransitionAnimator

@onready var ui_heart_1: Sprite2D = $InterfaceRight/UIheart1
@onready var ui_heart_2: Sprite2D = $InterfaceRight/UIheart2
@onready var ui_heart_3: Sprite2D = $InterfaceRight/UIheart3
var i_heartsLive := 3


#START TRANSITION
func Do_Transition(val: int) -> void:
	if val == -1:
		game.i_transitionCount -= 1
		animator.play("transition_play_fadeout")
	elif val == 0:
		animator.play("transition_text_fadeout")
	elif val == 1:
		animator.play("transition_play_fadeout")
	elif val == 2:
		$"../INTROTRANSITION".play("outroTransition")

#UI TRANSITION MANAGEMENT
func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "transition_text_fadeout" || anim_name == "transition_play_fadeout":
		if game.i_transitionCount == 1 || game.i_transitionCount == 4 || game.i_transitionCount == 7 || game.i_transitionCount == 10:
			animator.play("transition_play_fadein")
		else:
			animator.play("transition_text_fadein")
		SIG_midTransition.emit()
	
	if anim_name == "transition_play_fadein" || anim_name == "transition_text_fadein":
		SIG_finishedTransition.emit()

signal SIG_midTransition
signal SIG_finishedTransition

#region hearts

func ChangeHearts(val: int) -> void:
	if val == 1:
		if i_heartsLive >= 3:
			return
		i_heartsLive += 1
		if i_heartsLive == 3:
			ui_heart_1.modulate = "ff0036"
			$InterfaceRight/UIheart1/AnimationPlayer.play("heartBump")
		elif i_heartsLive == 2: 
			ui_heart_2.modulate = "ff0036"
			$InterfaceRight/UIheart2/AnimationPlayer.play("heartBump")
		elif i_heartsLive == 1: 
			ui_heart_3.modulate = "ff0036"
			$InterfaceRight/UIheart3/AnimationPlayer.play("heartBump")
	elif val == -1:
		if i_heartsLive <= 0:
			return
		i_heartsLive -= 1
		if i_heartsLive == 0:
			ui_heart_3.modulate = Color.DIM_GRAY
			$InterfaceRight/UIheart3/AnimationPlayer.stop()
		if i_heartsLive == 1:
			ui_heart_2.modulate = Color.DIM_GRAY
			$InterfaceRight/UIheart2/AnimationPlayer.stop()
		if i_heartsLive == 2:
			ui_heart_1.modulate = Color.DIM_GRAY
			$InterfaceRight/UIheart1/AnimationPlayer.stop()

func _on_heart1_animation_finished(_anim_name: StringName) -> void:
	$InterfaceRight/UIheart1/AnimationPlayer.play("heartBump")

func _on_heart2_animation_finished(_anim_name: StringName) -> void:
	$InterfaceRight/UIheart2/AnimationPlayer.play("heartBump")

func _on_heart3_animation_finished(_anim_name: StringName) -> void:
	$InterfaceRight/UIheart3/AnimationPlayer.play("heartBump")
#endregion
