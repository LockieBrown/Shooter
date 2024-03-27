extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$final_score/score.text = str(Global.Score)

func _on_exit_pressed():
	get_tree().quit()
