extends Node2D

#variables and signals
signal hit

var speed = 400

#how many enemys can be shot with 1 bullet
var Pierce_left = Global.pierce


func _ready():
	#despawn timer
	$despawn.wait_time = Global.despawn
	$despawn.start()
	
	$Area2D.scale = Vector2(Global.bullet_size, Global.bullet_size)

#movement of bullet
func _physics_process(delta):
	position += transform.x * speed * delta
	if Pierce_left <= 0:
		queue_free()

#deletion of bullet
func _on_area_2d_body_entered(body):
	if body.is_in_group("navigation"):
		queue_free()


#bullet can only last 1 second
func _on_despawn_timeout():
	queue_free()
