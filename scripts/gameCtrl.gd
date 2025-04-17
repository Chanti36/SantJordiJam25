extends Node2D

@onready var introTransition: AnimationPlayer = $INTROTRANSITION
@onready var ui: Control = $UI
@onready var textSystem: RichTextLabel = $UI/TextSystem


enum GameState { INTRONPC, GAMEPLAY, ENDINGNPC }
var state := GameState.INTRONPC

var b_startgame := false

var i_transitionCount := 0

#region Start

func _ready() -> void:
	$UI/Transition.position = Vector2(0, 0)
	introTransition.play("introTransition")

#FADE IN INTO SCENE
func _on_introtransition_finished(anim_name: StringName) -> void:
	b_startgame = true
	$UI/AnimationPlayer.play("transition_OUT")
#endregion


#region TextManagement

func _on_text_display_finished() -> void:
	ui.Do_Transition()

#endregion

#region Transitions

#from: 
#1 fade in
#2 char 1 in
#3 gameplay 1
#4 char 1 out
#5 char 2 in
#6 gameplay 2
#7 char 2 out
#8 char 3 in
#9 gameplay 3
#10 char 3 out
#11 char 4 in
#12 end?????
#13


func _on_ui_mid_transition() -> void:
	if i_transitionCount ==  1 : $RPGprint.visible = false #prepare gameplay1
	if i_transitionCount ==  2 : print("asd") #prepare out 1
	if i_transitionCount ==  3 : print("asd") #prepare in 2
	if i_transitionCount ==  4 : print("asd") #prepare gameplay2
	if i_transitionCount ==  5 : print("asd") #prepare gameplay2
	if i_transitionCount ==  6 : print("asd") #prepare out 2
	if i_transitionCount ==  7 : print("asd") #prepare in 3
	if i_transitionCount ==  8 : print("asd") #prepare gameplay3
	if i_transitionCount ==  9 : print("asd") #prepare out 3
	if i_transitionCount == 10 : print("asd") #prepare in 4
	if i_transitionCount == 11 : print("asd") #prepare out 4
	if i_transitionCount == 12 : print("asd") #prepare ending

#UI TRANSITION FINISHED
func _on_ui_finished_transition() -> void:
	i_transitionCount += 1
	if i_transitionCount ==  1: textSystem.StartConversation(1) #in 1
	if i_transitionCount ==  2: print("gameplay 1")
	if i_transitionCount ==  3: textSystem.StartConversation(2) #out 1
	if i_transitionCount ==  4: textSystem.StartConversation(3) #in 2
	if i_transitionCount ==  5: print("gameplay 2")
	if i_transitionCount ==  6: textSystem.StartConversation(4) #out 2
	if i_transitionCount ==  7: textSystem.StartConversation(5) #in 3
	if i_transitionCount ==  8: print("gameplay 3")
	if i_transitionCount ==  9: textSystem.StartConversation(6) #out 3
	if i_transitionCount == 10: textSystem.StartConversation(7) #in 4
	if i_transitionCount == 11: textSystem.StartConversation(8) #out 4
	if i_transitionCount == 12: textSystem.StartConversation(9) #ending
#endregion
