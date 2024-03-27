extends CharacterBody2D

#variables and stuff
signal dead

#movement variables
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const acceleration = 20
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#bullet instancing variable
var Bullet = preload("res://scenes/bullet.tscn")
var Grenade = preload("res://scenes/grenade.tscn")
var Stun_gun = preload("res://scenes/stun_area.tscn")


#gun textures
var shotgun_texture = preload("res://assets/My Assets/Shotgun.png")
var submachine_gun_texture = preload("res://assets/My Assets/Submachine Gun.png")
var marksman_rifle_texture = preload("res://assets/My Assets/Marksman Rifle.png")
var stun_gun_texture = preload("res://assets/My Assets/stun_gun.png")

#mouse pos
var mouse_position

#is_in = enemys in damage detection
var is_in = 0

#if gun can shoot
var can_shoot = true

#bps = bullets per shot
var Bps_left

#ammo in mag left
var Mag_left

#if reloading
var reloading = false


#movement
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		$jump_buffer.start()
	
	if Input.is_action_pressed("Jump") and $jump_buffer.time_left > 0:
		$jump_buffer.stop()
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("Right"):
		velocity.x = min(velocity.x + acceleration, SPEED)
	elif Input.is_action_pressed("Left"):
		velocity.x = max(velocity.x - acceleration, -SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, 30)
	
	move_and_slide()

func _ready():

	
	#gun presets
	if Global.Gun_type == Global.Gun.Shotgun:
		Global.Ammo = 48
		Global.Mag = 2
		Global.Spread = 0.15
		Global.Delay = 1
		Global.Reload = 2
		Global.Damage = 40
		Global.Bps = 6
		Global.Speed = 400
		Global.Hold = false
		Global.pierce = 2
		$marker_guide/Sprite2D.texture = shotgun_texture
		$marker_guide/Sprite2D/CPUParticles2D.amount = 1
		$marker_guide/Sprite2D/CPUParticles2D.lifetime = 0.5
	elif Global.Gun_type == Global.Gun.Submachine_gun:
		Global.Ammo = 200
		Global.Mag = 40
		Global.Spread = 0.1
		Global.Delay = 0.1
		Global.Reload = 4
		Global.Damage = 40
		Global.Bps = 1
		Global.Speed = 400
		Global.Hold = true
		Global.pierce = 1
		$marker_guide/Sprite2D.texture = submachine_gun_texture
		$marker_guide/Sprite2D/CPUParticles2D.amount = 10
		$marker_guide/Sprite2D/CPUParticles2D.lifetime = 2
	elif Global.Gun_type == Global.Gun.Marksman_rifle:
		Global.Ammo = 40
		Global.Mag = 10
		Global.Spread = 0.001
		Global.Delay = 1
		Global.Reload = 3
		Global.Damage = 200
		Global.Bps = 1
		Global.Speed = 600
		Global.Hold = false
		Global.pierce = 3
		$marker_guide/Sprite2D.texture = marksman_rifle_texture
		$marker_guide/Sprite2D/CPUParticles2D.amount = 1
		$marker_guide/Sprite2D/CPUParticles2D.lifetime = 2
		
	Global.Ammo_left = Global.Ammo
	Mag_left = Global.Mag
	
#some inputs
func _input(event):
	#reload
	if event.is_action_pressed("Reload") && Mag_left < Global.Mag:
		$reload.start()
		
	#secondaries
	if event.is_action_pressed("Secondary"):
		#grenade
		if Global.Secondary_type == Global.Secondary.Grenade && $grenade_delay.time_left == 0:
			var grenade = Grenade.instantiate()
			owner.add_child(grenade)
			grenade.transform = $".".transform
			$grenade_delay.start()
		#stun gun
		if Global.Secondary_type == Global.Secondary.Stun_gun && $stun_delay.time_left == 0:
			var stun_gun = Stun_gun.instantiate()
			owner.add_child(stun_gun)
			stun_gun.transform = $marker_guide/Marker2D.global_transform
			$stun_delay.start()
			#texture switching
			$marker_guide/Sprite2D.texture = stun_gun_texture
			$marker_guide/Sprite2D.scale = Vector2(0.7, 0.7)
			await get_tree().create_timer(1).timeout
			$marker_guide/Sprite2D.scale = Vector2(1, 1)
			if Global.Gun_type == Global.Gun.Shotgun:
				$marker_guide/Sprite2D.texture = shotgun_texture
			elif Global.Gun_type == Global.Gun.Submachine_gun:
				$marker_guide/Sprite2D.texture = submachine_gun_texture
			elif Global.Gun_type == Global.Gun.Marksman_rifle:
				$marker_guide/Sprite2D.texture = marksman_rifle_texture
				
func _process(delta):
	#restock soon message

	if Global.Ammo_left < Global.Mag &&  Global.restock_soon_message_played == false:
		Global.message.play("restocksoon")
		Global.restock_soon_message_played = true
	
	Global.message = $AnimationPlayer
	#health
	$CanvasLayer/TextureProgressBar.value = Global.health
	
	#stun delay time
	$stun_delay.wait_time = Global.stun_delay
	
	#light
	if Global.Level == 1:
		$PointLight2D.enabled = false
	elif Global.Level == 2:
		$PointLight2D.enabled = true
	
	#HUD visiblity
	if Global.HUD_visible == true:
		$CanvasLayer.visible = true
	elif Global.HUD_visible == false:
		$CanvasLayer.visible = false
	
	#marker rotation
	mouse_position = get_local_mouse_position()
	$marker_guide.rotation = mouse_position.angle()
	
	#shot delay
	$delay.set_wait_time(Global.Delay)
	
	#reload time
	$reload.set_wait_time(Global.Reload)
	
	#Damage
	if is_in > 0:
		var time = 1.0 / is_in
		$Damage_timer.set_wait_time(time)
	
	#Shoot detection
	if Input.is_action_just_pressed("Shoot") && can_shoot == true && $spawndelay.time_left == 0 && Global.Hold == false && Global.can_shoot == true:
		shoot()
		can_shoot = false
		$delay.start()
	elif Input.is_action_pressed("Shoot") && can_shoot == true && $spawndelay.time_left == 0 && Global.Hold == true && Global.can_shoot == true:
		shoot()
		can_shoot = false
		$delay.start()
	
	#mag detection
	if Mag_left <= 0 && reloading == false:
		reloading = true
		$reload.start()
	
	#texture flipping
	if get_local_mouse_position().x < 0 :
		$marker_guide/Sprite2D.flip_v = true
		if Global.Gun_type == Global.Gun.Shotgun:
			$marker_guide/Marker2D.position.y = 2
		elif Global.Gun_type == Global.Gun.Submachine_gun:
			$marker_guide/Marker2D.position.y = 5
		elif Global.Gun_type == Global.Gun.Marksman_rifle:
			$marker_guide/Marker2D.position.y = 0
	else:
		$marker_guide/Sprite2D.flip_v = false
		if Global.Gun_type == Global.Gun.Shotgun:
			$marker_guide/Marker2D.position.y = -2
		elif Global.Gun_type == Global.Gun.Submachine_gun:
			$marker_guide/Marker2D.position.y = -5
		elif Global.Gun_type == Global.Gun.Marksman_rifle:
			$marker_guide/Marker2D.position.y = 0
			
	#death
	if $CanvasLayer/TextureProgressBar.value == 0:
		get_tree().change_scene_to_file("res://scenes/failure.tscn")
	
	#labels
	$CanvasLayer/Gun_type.text = str(Global.Gun_type)
	$CanvasLayer/Mag.text = str(Mag_left)
	$CanvasLayer/Ammo.text = str(Global.Ammo_left)
	$CanvasLayer/Money.text = str(Global.money)
	$CanvasLayer/score_label.text = str(Global.Score)
	$CanvasLayer/level_label.text = str(Global.Player_level)
	
	
#shoot function
func shoot():
	Bps_left = Global.Bps
	if Mag_left > 0:
		Mag_left -= 1
		$marker_guide/Sprite2D/CPUParticles2D.set_emitting(true)
		while Bps_left > 0:
			Bps_left -= 1
			var bullet = Bullet.instantiate()
			owner.add_child(bullet)
			$marker_guide.rotation = mouse_position.angle()
			$marker_guide.rotation += randf_range(-Global.Spread, Global.Spread)
			bullet.transform = $marker_guide/Marker2D.global_transform


#damage detection
func _on_death_detection_area_entered(area):
	if area.is_in_group("enemy"):
		is_in += 1

func _on_death_detection_area_exited(area):
	if area.is_in_group("enemy"):
		is_in -= 1

func _on_damage_timer_timeout():
	if is_in > 0:
		Global.health -= 1

#shoot timer
func _on_shoot_timer_timeout():
	can_shoot = true

#reload
func _on_reload_timeout():
	if Global.Ammo_left > 0:
		var Ammo_to_transfer = (Global.Mag - Mag_left)
		if Global.Ammo_left - Ammo_to_transfer >= 0:
			Global.Ammo_left -= Ammo_to_transfer
			Mag_left += Ammo_to_transfer
		else:
			Mag_left = Global.Ammo_left
			Global.Ammo_left = 0
		
		reloading = false

#money collection
func _on_money_collect_body_entered(body):
	if body.is_in_group("coin"):
		body.queue_free()
		Global.money += 1
