extends Node2D
#1312
@onready var introTransition: AnimationPlayer = $INTROTRANSITION
@onready var gameplay: Node2D = $GAMEPLAY
@onready var rpg: Control = $RPG
@onready var ui: Control = $UI
@onready var textSystem: RichTextLabel = $UI/TextSystem

@onready var bg = $RPG/BG
@onready var npc = $RPG/NPC

#region preload RPG sprites
const BG_1 = preload("res://sprites/rpg/bg1.png")
const BG_2 = preload("res://sprites/rpg/bg2.png")
const BG_3 = preload("res://sprites/rpg/bg3.png")
const BG_4 = preload("res://sprites/rpg/bg4.png")
const NPC_1 = preload("res://sprites/rpg/npc1.png")
const NPC_2 = preload("res://sprites/rpg/npc2.png")
const NPC_3 = preload("res://sprites/rpg/npc3.png")
const NPC_4 = preload("res://sprites/rpg/npc4.png")
#endregion

var i_transitionCount := 0

#region Start

func _ready() -> void:
	$UI/Transition.position = Vector2(0, 0)
	introTransition.play("introTransition")

#FADE IN INTO SCENE
func _on_introtransition_finished(anim_name: StringName) -> void:
	if anim_name == "introTransition":
		#DEBUG!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		#i_transitionCount = 1
		#rpg.visible = false
		#gameplay.visible = true
		#gameplay.SetUpGameplay(1)
		#$UI/TransitionAnimator.play("transition_play_fadein")
		
		$UI/TransitionAnimator.play("transition_text_fadein")
		#setup
		$RPG.visible = true
		$GAMEPLAY.visible = false
		npc.texture = NPC_1
		bg.texture = BG_1
	
	elif anim_name == "outroTransition":
		get_tree().change_scene_to_file("res://scenes/mainscene.tscn")
#endregion

#region TextManagement

func _on_text_display_finished() -> void:
	ui.Do_Transition(0)

#endregion

#region Transitions

func _on_ui_mid_transition() -> void:
	if i_transitionCount == 1: #prepare gameplay1
		rpg.visible = false
		gameplay.visible = true
		gameplay.SetUpGameplay(1)
	elif i_transitionCount == 2: #prepare out 1
		rpg.visible = true
		gameplay.visible = false
	elif i_transitionCount == 3:  #prepare in 2
		npc.texture = NPC_2
		bg.texture = BG_2
	elif i_transitionCount == 4: #prepare gameplay2
		rpg.visible = false 
		gameplay.visible = true
		gameplay.SetUpGameplay(2)
	elif i_transitionCount == 5: #prepare out 2
		rpg.visible = true
		gameplay.visible = false
	elif i_transitionCount == 6: #prepare in 3
		npc.texture = NPC_3
		bg.texture = BG_3
	elif i_transitionCount == 7:  #prepare gameplay3
		rpg.visible = false 
		gameplay.visible = true
		gameplay.SetUpGameplay(3)
	elif i_transitionCount == 8: #prepare out 3
		rpg.visible = true
		gameplay.visible = false
	elif i_transitionCount == 9: #prepare in 4
		npc.texture = NPC_4
		bg.texture = BG_4
	elif i_transitionCount == 10: #prepare out 4
		rpg.visible = false 
		gameplay.visible = true
		gameplay.SetUpGameplay(4)
	
	if $GAMEPLAY/Player.i_lives == 0:
		ui.ChangeHearts(1)
		ui.ChangeHearts(1)
		ui.ChangeHearts(1)
		$GAMEPLAY/Player.i_lives = 3
		ui.i_heartsLive = 3

#UI TRANSITION FINISHED
func _on_ui_finished_transition() -> void:
	i_transitionCount += 1
	if   i_transitionCount ==  1: textSystem.StartConversation(1) #in 1
	elif i_transitionCount ==  2: gameplay.StartGameplay() #print("gameplay 1"); ui.Do_Transition(1)
	elif i_transitionCount ==  3: textSystem.StartConversation(2) #out 1
	elif i_transitionCount ==  4: textSystem.StartConversation(3) #in 2
	elif i_transitionCount ==  5: gameplay.StartGameplay() #print("gameplay 2"); ui.Do_Transition(1)
	elif i_transitionCount ==  6: textSystem.StartConversation(4) #out 2
	elif i_transitionCount ==  7: textSystem.StartConversation(5) #in 3
	elif i_transitionCount ==  8: gameplay.StartGameplay() #print("gameplay 3"); ui.Do_Transition(1)
	elif i_transitionCount ==  9: textSystem.StartConversation(6) #out 3
	elif i_transitionCount == 10: textSystem.StartConversation(7) #in 4
	elif i_transitionCount == 11: gameplay.StartGameplay()
#endregion


# boss
# textos
# musica
#
# rosa
#
