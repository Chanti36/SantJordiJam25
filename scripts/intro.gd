extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("intro")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	print("finish")
	get_tree().change_scene_to_file("res://scenes/mainscene.tscn")
