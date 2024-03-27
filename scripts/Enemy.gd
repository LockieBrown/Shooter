extends CharacterBody2D

signal died(pos)

const jump_velocity = -400.0

var speed = randi_range(40,75)
var health = 20
var active: bool = false

var jump_distance
var can_jump
var next_path_pos
var stunned = false

var stun_amount

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var Stun_gun = preload("res://scenes/stun_area.tscn")

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	active = true
	await get_tree().create_timer(0.01).timeout
	position = Vector2(1980, 794)

#movement/pathing
func _physics_process(delta):
	#if type == "Flying":
	$NavigationAgent2D.set_navigation_layer_value(1, true)
	$NavigationAgent2D.set_navigation_layer_value(2, true)
	if active:
		next_path_pos = navigation_agent.get_next_path_position()
		var direction := global_position.direction_to(next_path_pos)
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	##ground is not used
	#if type == "Ground":
		#$NavigationAgent2D.set_navigation_layer_value(2, true)
		#if active:
			#next_path_pos = navigation_agent.get_next_path_position()
			#var direction := global_position.direction_to(next_path_pos)
			#velocity.x = direction.x * speed
		#else:
			#velocity = Vector2.ZERO
			#
		#if is_on_floor():
			#can_jump = true
		#
		#if not is_on_floor():
			#velocity.y += gravity * delta
		#
	
		#if next_path_pos.y < (position.y - 10) && can_jump == true && $jump_delay.time_left == 0:
			#velocity.y = jump_velocity
			#can_jump = false
			#$jump_delay.start()
	
	if stunned == true:
		active = false
	
	move_and_slide()

func _process(delta):
	#death detection
	if $TextureProgressBar.value == 0:
		died.emit(position)
		queue_free()
	
	#stun duratuion
	$stun.wait_time = Global.stun_duration
	
#pathing update
func _on_timer_timeout():
	var player = Global.Player
	navigation_agent.target_position = player.global_position

#hit detection
func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		$TextureProgressBar.value -= Global.Damage
	elif area.is_in_group("sentry_bullet"):
		$TextureProgressBar.value -= Global.Sentry_damage
	elif area.is_in_group("grenade"):
		$TextureProgressBar.value -= Global.Grenade_damage
		if Global.Grenade_stuns == true:
			stunned = true
	elif area.is_in_group("stun_bullet") && stunned == false:
		$TextureProgressBar.value -= Global.stun_damage
		stunned = true
		$stun.start()
		var stun_gun = Stun_gun.instantiate()
		add_sibling(stun_gun)
		stun_gun.position = position
		stun_gun.rotation_degrees = randi_range(0,360)
		

#stun changes
func _on_stun_timeout():
	stunned = false
	active = true
