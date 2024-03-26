extends Control

func _on_button_pressed():
		get_tree().change_scene_to_file("res://scenes/loadout.tscn")

func _input(event):
	if event.is_action_pressed("Escape"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
