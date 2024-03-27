extends Node2D

func _ready():
	await get_tree().create_timer(0.1).timeout
	Global.Touching_shop = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("character"):
		Global.Touching_shop = true
	
func _on_area_2d_body_exited(body):
	if body.is_in_group("character"):
		Global.Touching_shop = false
