extends Control

#gun and secondary selection
func _input(event):
	if event.is_action_pressed("Escape"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_pressed():
	Global.Gun_type = Global.Gun.Shotgun


func _on_button_2_pressed():
	Global.Gun_type = Global.Gun.Submachine_gun


func _on_button_3_pressed():
	Global.Gun_type = Global.Gun.Marksman_rifle


func _on_button_4_pressed():
	Global.Secondary_type = Global.Secondary.Grenade


func _on_button_5_pressed():
	Global.Secondary_type = Global.Secondary.Sentry


func _on_button_6_pressed():
	Global.Secondary_type = Global.Secondary.Stun_gun

#play button
func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	

func _process(delta):
	#disable button if no weapon selected
	if Global.Gun_type == null && Global.Secondary_type == null:
		$ButtonPlay.disabled = true
	elif Global.Gun_type != null && Global.Secondary_type != null:
		$ButtonPlay.disabled = false
	
	#updating selected weapon descriptions
	if Global.Gun_type == Global.Gun.Shotgun:
		$text_background/Primary_weapon_label.text = "Primary: Shotgun"
		$text_background/Primary_weapon_description.text = "The Shotgun shoots many bullets at once but with a wide spread, has a small amount bullets per reload and has a large amount of max ammo"
	elif Global.Gun_type == Global.Gun.Submachine_gun:
		$text_background/Primary_weapon_label.text = "Primary: Submachine Gun"
		$text_background/Primary_weapon_description.text = "The submachine Gun fires very fast meaning you can hold the button to fire, has many bullets per magazine and has a high max ammo"
	elif Global.Gun_type == Global.Gun.Marksman_rifle:
		$text_background/Primary_weapon_label.text = "Primary: Marksman Rifle"
		$text_background/Primary_weapon_description.text = "The Marksman Rifle only shoots one bullet per second but has very high damage and very high pierce, but has a low amount of bullet per reload and a small amount of max ammo"
	
	if Global.Secondary_type == Global.Secondary.Grenade:
		$text_background/Secondary_weapon_label.text = "Secondary: Grenade"
		$text_background/Secondary_weapon_description.text = "The Grenade can be thrown every few seconds exploding after a short duration, dealing high damage to any enemy in its range"
	elif Global.Secondary_type == Global.Secondary.Sentry:
		$text_background/Secondary_weapon_label.text = "Secondary: Sentry Gun"
		$text_background/Secondary_weapon_description.text = "The Sentry Gun will detect when an enemy enters its detection range, shown through a radar scan, and shoot at it"
	elif Global.Secondary_type == Global.Secondary.Stun_gun:
		$text_background/Secondary_weapon_label.text = "Secondary: Stun Gun"
		$text_background/Secondary_weapon_description.text = "The Stun Gun has a short range before the energy dissipates, stunning any enemy it hits, this will also chain to nearby enemies, stunning them too"
