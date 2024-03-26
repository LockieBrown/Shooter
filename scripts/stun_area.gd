extends Node2D

#signals and variables
signal hit

var speed = 400

var moving = true

#how many enemys can be shot with 1 bullet
var Pierce_left = Global.Stun_gun_pierce

#start the timer for a bullet to only exist for 0.1 second
func _ready():
	$despawn.wait_time = Global.stun
	$despawn.start()
	$Area2D2.scale = Vector2(Global.Stun_size, Global.Stun_size)

#movement of bullet
func _physics_process(delta):
	if moving == true:
		position += transform.x * speed * delta
	if Pierce_left <= 0:
		queue_free()
	
#deletion of bullet
func _on_area_2d_body_entered(body):
	if body.is_in_group("navigation"):
		queue_free()
	moving = false
	await get_tree().create_timer(0.2).timeout
	Pierce_left -=1

#bullet can only last 0.1 second
func _on_despawn_timeout():
	queue_free()
