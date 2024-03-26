extends Node2D

#variables
var target = null
var vaild = false
var can_shoot = true

var Bullet = preload("res://scenes/sentry_bullet.tscn")

#delete sentry if was not chosen
func _ready():
	if Global.Secondary_type != Global.Secondary.Sentry:
		queue_free()


func _process(delta):
	if target != null:
		#aim and fire
		$marker_guide.look_at(target.position)
		if can_shoot == true: 
			shoot()
			can_shoot = false
			$delay.start()
		$delay.wait_time = Global.Sentry_delay
		
		#texture flipping
		if to_local(target.position).x < 0:
			$marker_guide/Sprite2D.flip_v = true
		elif to_local(target.position).x > 0:
			$marker_guide/Sprite2D.flip_v = false
		
	#scan
	elif vaild == false && $scan_delay.time_left == 0:
		$scan_delay.start()
		if Global.sentry_double_range == false:
			$AnimationPlayer.play("scanning")
			$Area2D.scale = Vector2(1,1)
		elif Global.sentry_double_range == true:
			$AnimationPlayer.play("scanning_double")
			$Area2D.scale = Vector2(2,2)
		var current_pos = position
		await get_tree().create_timer(0.01).timeout
		position = Vector2(-100,-100)
		await get_tree().create_timer(0.01).timeout
		position = current_pos
	
	#checking if current target has been deleted
	vaild = is_instance_valid(target)
	
	#move to player
	if Input.is_action_just_pressed("Secondary"):
		position = Global.Player.position
		rotation = 0
	
# get target
func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy"):
		target = area.owner

#shoot
func shoot():
	var bullet = Bullet.instantiate()
	owner.add_child(bullet)
	bullet.transform = $marker_guide/Marker2D.global_transform

#shoot delay
func _on_delay_timeout():
	can_shoot = true
