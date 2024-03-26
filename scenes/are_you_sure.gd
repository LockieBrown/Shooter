extends Control



func _on_yes_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_no_pressed():
	$".".visible = false
