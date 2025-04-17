extends Control
@onready var animator: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass

#START TRANSITION
func Do_Transition():
	animator.play("transition_IN")

#UI TRANSITION MANAGEMENT
func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "transition_play_fadeout":
		animator.play("transition_text_fadein")
		SIG_midTransition.emit()
	
	if anim_name == "transition_text_fadeout":
		animator.play("transition_play_fadein")
		SIG_midTransition.emit()
	
	if anim_name == "transition_play_fadein" || anim_name == "tansition_text_fadein":
		SIG_finishedTransition.emit()

signal SIG_midTransition
signal SIG_finishedTransition
