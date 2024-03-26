extends Control

#currently no setting, if i add any they will be here
func _input(event):
	if event.is_action_pressed("Escape"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
