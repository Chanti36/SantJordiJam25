extends Control

func _input(event: InputEvent) -> void:
	if event.is_action("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/intro.tscn")
