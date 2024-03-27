extends RigidBody2D

#hide explosion size
func _ready():
	$PointLight2D.visible = false
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	apply_central_impulse(Vector2(Global.Player.get_local_mouse_position()) * 2)
	

func _process(delta):
	$Area2D.scale = Vector2(Global.Grenade_size,Global.Grenade_size)
	$Timer.wait_time(1.5)

#explodes showing size
func _on_timer_timeout():
	$PointLight2D.visible = true
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	await get_tree().create_timer(0.2).timeout
	queue_free()
