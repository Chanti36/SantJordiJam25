extends Control


func _ready() -> void:
	$AnimationPlayer.play("startCredits")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
