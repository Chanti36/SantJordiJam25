extends Control
@onready var animator: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

#START TRANSITION
func Do_Transition():
	animator.play("transition_IN")

#UI TRANSITION MANAGEMENT
func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "transition_IN":
		animator.play("transition_OUT")
		SIG_midTransition.emit()
	if anim_name == "transition_OUT":
		print("FINISHED_TRANSITION")
		SIG_finishedTransition.emit()

signal SIG_midTransition
signal SIG_finishedTransition
