extends Node2D

#variables and signals
signal hit

var speed = 400

#how many enemys can be shot with 1 bullet
var Pierce_left = Global.Sentry_pierce

#start timer to delete bullet after 1 second
func _ready():
	$despawn.wait_time = Global.sentry_despawn
	$despawn.start()

#movement of bullet
func _physics_process(delta):
	position += transform.x * speed * delta
	if Pierce_left <= 0:
		queue_free()

#deletion of bullet
func _on_area_2d_body_entered(body):
	if body.is_in_group("navigation"):
		queue_free()
	Pierce_left -=1

#bullet can only last 1 second
func _on_despawn_timeout():
	queue_free()
