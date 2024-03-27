extends Control

#weapon textures
var shotgun_texture = preload("res://assets/My Assets/Shotgun.png")
var submachine_gun_texture = preload("res://assets/My Assets/Submachine Gun.png")
var marksman_rifle_texture = preload("res://assets/My Assets/Marksman Rifle.png")
var grenade_texture = preload("res://assets/My Assets/Grenade.png")
var sentry_gun_texture = preload("res://assets/My Assets/Sentry_Icon.png")
var stun_gun_texture = preload("res://assets/My Assets/stun_gun.png")

#currently selected buttons
var primary_option = 0
var secondary_option = 0
var current_upgrade = 0

func _process(delta):
	if Global.money >= 10:
		$heal.disabled = false
	elif Global.money <= 10:
		$heal.disabled = true
		
	if Global.money >= 30:
		$restock.disabled = false
	elif Global.money <= 30:
		$restock.disabled = true
	
	if primary_option != 0 && secondary_option != 0:
		$confirm.disabled = false
	elif primary_option == 0 && secondary_option == 0:
		$confirm.disabled = true
		
	if Global.Gun_type == Global.Gun.Shotgun:
		$primary_label/TextureRect.texture = shotgun_texture
	elif Global.Gun_type == Global.Gun.Submachine_gun:
		$primary_label/TextureRect.texture = submachine_gun_texture
	elif Global.Gun_type == Global.Gun.Marksman_rifle:
		$primary_label/TextureRect.texture = marksman_rifle_texture
	if Global.Secondary_type == Global.Secondary.Grenade:
		$secondary_label/TextureRect.texture = grenade_texture
	elif Global.Secondary_type == Global.Secondary.Sentry:
		$secondary_label/TextureRect.texture = sentry_gun_texture
	elif Global.Secondary_type == Global.Secondary.Stun_gun:
		$secondary_label/TextureRect.texture = stun_gun_texture
	
	
	if Global.Player_level < 1:
		$primary_label/GridContainer/primary_option_1.text = ("Locked")
		$primary_label/GridContainer/primary_option_2.text = ("Locked")
		$secondary_label/GridContainer/seconary_option_1.text = ("Locked")
		$secondary_label/GridContainer/seconary_option_2.text = ("Locked")
		$primary_label/RichTextLabel.text = ("")
		$secondary_label/RichTextLabel.text = ("")
		$primary_label/GridContainer/primary_option_1.disabled = true
		$primary_label/GridContainer/primary_option_2.disabled = true
		$secondary_label/GridContainer/seconary_option_1.disabled = true
		$secondary_label/GridContainer/seconary_option_2.disabled = true
	elif Global.Player_level >= 1 && current_upgrade == 0:
		$primary_label/GridContainer/primary_option_1.disabled = false
		$primary_label/GridContainer/primary_option_2.disabled = false
		$secondary_label/GridContainer/seconary_option_1.disabled = false
		$secondary_label/GridContainer/seconary_option_2.disabled = false
		if Global.Gun_type == Global.Gun.Shotgun:
			$primary_label/GridContainer/primary_option_1.text = ("Shotgun Surge Kit")
			$primary_label/GridContainer/primary_option_2.text = ("Magazine Expansion Module")
		elif Global.Gun_type == Global.Gun.Submachine_gun:
			$primary_label/GridContainer/primary_option_1.text = ("Impact Intensifier")
			$primary_label/GridContainer/primary_option_2.text = ("Pinpoint Accuracy Kit")
		elif Global.Gun_type == Global.Gun.Marksman_rifle:
			$primary_label/GridContainer/primary_option_1.text = ("Pierce Enhancer Module")
			$primary_label/GridContainer/primary_option_2.text = ("Speed Shooter Kit")
		if Global.Secondary_type == Global.Secondary.Grenade:
			$secondary_label/GridContainer/seconary_option_1.text = ("Blast Amplifier")
			$secondary_label/GridContainer/seconary_option_2.text = ("Explosive Impact Boost")
		elif Global.Secondary_type == Global.Secondary.Sentry:
			$secondary_label/GridContainer/seconary_option_1.text = ("Sentry Strike Module")
			$secondary_label/GridContainer/seconary_option_2.text = ("Sentry Quickfire Augment")
		elif Global.Secondary_type == Global.Secondary.Stun_gun:
			$secondary_label/GridContainer/seconary_option_1.text = ("Electric Field Extender")
			$secondary_label/GridContainer/seconary_option_2.text = ("Stun Field Amplifier")
	elif Global.Player_level >= 2 && current_upgrade == 1:
		$primary_label/GridContainer/primary_option_1.disabled = false
		$primary_label/GridContainer/primary_option_2.disabled = false
		$secondary_label/GridContainer/seconary_option_1.disabled = false
		$secondary_label/GridContainer/seconary_option_2.disabled = false
		if Global.Gun_type == Global.Gun.Shotgun:
			$primary_label/GridContainer/primary_option_1.text = ("Shotgun Payload Expander")
			$primary_label/GridContainer/primary_option_2.text = ("Rapid Burst Module")
		elif Global.Gun_type == Global.Gun.Submachine_gun:
			$primary_label/GridContainer/primary_option_1.text = ("Bullet Piercer Attachment")
			$primary_label/GridContainer/primary_option_2.text = ("Damage Intensifier Kit")
		elif Global.Gun_type == Global.Gun.Marksman_rifle:
			$primary_label/GridContainer/primary_option_1.text = ("Extra Capacity Kit")
			$primary_label/GridContainer/primary_option_2.text = ("Rifle Bullet Enlarger")
		if Global.Secondary_type == Global.Secondary.Grenade:
			$secondary_label/GridContainer/seconary_option_1.text = ("Blinding Explosive")
			$secondary_label/GridContainer/seconary_option_2.text = ("Quickburst Explosive")
		elif Global.Secondary_type == Global.Secondary.Sentry:
			$secondary_label/GridContainer/seconary_option_1.text = ("Damage Overload System")
			$secondary_label/GridContainer/seconary_option_2.text = ("Rapidfire Sentry Kit")
		elif Global.Secondary_type == Global.Secondary.Stun_gun:
			$secondary_label/GridContainer/seconary_option_1.text = ("Electric Shock Augment")
			$secondary_label/GridContainer/seconary_option_2.text = ("Stun Prolongation Module")
	elif Global.Player_level >= 3 && current_upgrade == 2:
		$primary_label/GridContainer/primary_option_1.disabled = false
		$primary_label/GridContainer/primary_option_2.disabled = false
		$secondary_label/GridContainer/seconary_option_1.disabled = false
		$secondary_label/GridContainer/seconary_option_2.disabled = false
		if Global.Gun_type == Global.Gun.Shotgun:
			$primary_label/GridContainer/primary_option_1.text = ("Tight Shot Penetrator")
			$primary_label/GridContainer/primary_option_2.text = ("Giant Pellet Mod")
		elif Global.Gun_type == Global.Gun.Submachine_gun:
			$primary_label/GridContainer/primary_option_1.text = ("Supersonic SMG Mod")
			$primary_label/GridContainer/primary_option_2.text = ("Extended Ammo Reservoir")
		elif Global.Gun_type == Global.Gun.Marksman_rifle:
			$primary_label/GridContainer/primary_option_1.text = ("Rifle Penetration Enhancement")
			$primary_label/GridContainer/primary_option_2.text = ("Rapid Response Kit")
		if Global.Secondary_type == Global.Secondary.Grenade:
			$secondary_label/GridContainer/seconary_option_1.text = ("High-Impact Mini-Grenade")
			$secondary_label/GridContainer/seconary_option_2.text = ("Oversized Impact Reducer")
		elif Global.Secondary_type == Global.Secondary.Sentry:
			$secondary_label/GridContainer/seconary_option_1.text = ("Enhanced Radar Coverage")
			$secondary_label/GridContainer/seconary_option_2.text = ("Sentry Sacrifice Augment")
		elif Global.Secondary_type == Global.Secondary.Stun_gun:
			$secondary_label/GridContainer/seconary_option_1.text = ("Quickfire Stun Gun Kit")
			$secondary_label/GridContainer/seconary_option_2.text = ("Stun Range Extender")
	else:
		$primary_label/GridContainer/primary_option_1.disabled = true
		$primary_label/GridContainer/primary_option_2.disabled = true
		$secondary_label/GridContainer/seconary_option_1.disabled = true
		$secondary_label/GridContainer/seconary_option_2.disabled = true

func _on_primary_option_1_pressed():
	if Global.Player_level >= 1 && current_upgrade == 0:
		if Global.Gun_type == Global.Gun.Shotgun:
			$primary_label/RichTextLabel.text = ("+ Increases fire rate by 0.2")
		elif Global.Gun_type == Global.Gun.Submachine_gun:
			$primary_label/RichTextLabel.text = ("+ Increases Damage by 20")
		elif Global.Gun_type == Global.Gun.Marksman_rifle:
			$primary_label/RichTextLabel.text = ("+ Increase Pierce by 2")
	elif Global.Player_level >= 2 && current_upgrade == 1:
		if Global.Gun_type == Global.Gun.Shotgun:
			$primary_label/RichTextLabel.text = ("+ increase bullets per shot by 2\n_ decrease rate of fire by 0.5 seconds")
		elif Global.Gun_type == Global.Gun.Submachine_gun:
			$primary_label/RichTextLabel.text = ("+ gun gets 1 pierce\n_ max ammo decreased by 40")
		elif Global.Gun_type == Global.Gun.Marksman_rifle:
			$primary_label/RichTextLabel.text = ("+ max ammo increased by 40\n_ decreased rate of fire by 0.5 seconds")
	elif Global.Player_level >= 3 && current_upgrade == 2:
		if Global.Gun_type == Global.Gun.Shotgun:
			$primary_label/RichTextLabel.text = ("+ decrease spread by 0.05\n+ increase pierce by 2\n_ decrease rate of fire by 0.5 seconds")
		elif Global.Gun_type == Global.Gun.Submachine_gun:
			$primary_label/RichTextLabel.text = ("+ half the rate of fire\n_ decrease damage by 20%")
		elif Global.Gun_type == Global.Gun.Marksman_rifle:
			$primary_label/RichTextLabel.text = ("+ increase pierce by 2\n_ mag size decreased by 2")
	primary_option = 1


func _on_primary_option_2_pressed():
	if Global.Player_level >= 1 && current_upgrade == 0:
		if Global.Gun_type == Global.Gun.Shotgun:
			$primary_label/RichTextLabel.text = ("+ Increases Magazine size by 2")
		elif Global.Gun_type == Global.Gun.Submachine_gun:
			$primary_label/RichTextLabel.text = ("+ Decrease spread by 0.05")
		elif Global.Gun_type == Global.Gun.Marksman_rifle:
			$primary_label/RichTextLabel.text = ("+ Increase rate of fire by 0.25 seconds")
	elif Global.Player_level >= 2 && current_upgrade == 1:
		if Global.Gun_type == Global.Gun.Shotgun:
			$primary_label/RichTextLabel.text = ("+ increase rate of fire by 0.3\n_ decrease bullets per shot by 2")
		elif Global.Gun_type == Global.Gun.Submachine_gun:
			$primary_label/RichTextLabel.text = ("+ increase damage by 30\n_ decrease rate of fire by 0.2 seconds")
		elif Global.Gun_type == Global.Gun.Marksman_rifle:
			$primary_label/RichTextLabel.text = ("+ increase bullet size by 50%\n_ increase spread by 0.02")
	elif Global.Player_level >= 3 && current_upgrade == 2:
		if Global.Gun_type == Global.Gun.Shotgun:
			$primary_label/RichTextLabel.text = ("+ increase rate of fire by 0.4 seconds\n+ increase bullet size by 50%\n_ max ammo decreased by 16")
		elif Global.Gun_type == Global.Gun.Submachine_gun:
			$primary_label/RichTextLabel.text = ("+ increase mag size by 20%\n+ increase max ammo by 100\n_ decrease rate of fire by 0.03")
		elif Global.Gun_type == Global.Gun.Marksman_rifle:
			$primary_label/RichTextLabel.text = ("+ increase rate of fire by 50%\n_ max ammo decreases by 20%")
	primary_option = 2

func _on_seconary_option_1_pressed():
	if Global.Player_level >= 1 && current_upgrade == 0:
		if Global.Secondary_type == Global.Secondary.Grenade:
			$secondary_label/RichTextLabel.text = ("+ Increase explosion size by 25%")
		elif Global.Secondary_type == Global.Secondary.Sentry:
			$secondary_label/RichTextLabel.text = ("+ Increase damage by 20")
		elif Global.Secondary_type == Global.Secondary.Stun_gun:
			$secondary_label/RichTextLabel.text = ("+ triple bullet range")
	elif Global.Player_level >= 2 && current_upgrade == 1:
		if Global.Secondary_type == Global.Secondary.Grenade:
			$secondary_label/RichTextLabel.text = ("+ stun enemies for 0.5 seconds\n_ decrease damage by 50")
		elif Global.Secondary_type == Global.Secondary.Sentry:
			$secondary_label/RichTextLabel.text = ("+ increase damage by 30\n_ decrease bullet duration by 50%")
		elif Global.Secondary_type == Global.Secondary.Stun_gun:
			$secondary_label/RichTextLabel.text = ("+ does a small amount of damage(20)\n_ decrease stun duration by 0.3 seconds")
	elif Global.Player_level >= 3 && current_upgrade == 2:
		if Global.Secondary_type == Global.Secondary.Grenade:
			$secondary_label/RichTextLabel.text = ("+ increase explosion size by 50%\n_ decrease damage by 25%")
		elif Global.Secondary_type == Global.Secondary.Sentry:
			$secondary_label/RichTextLabel.text = ("+ double detection range\n_ fire rate decrease by 10%")
		elif Global.Secondary_type == Global.Secondary.Stun_gun:
			$secondary_label/RichTextLabel.text = ("+ rate of fire increased by 50%\n_ stun size decreased by 25%")
	secondary_option = 1

func _on_seconary_option_2_pressed():
	if Global.Player_level >= 1 && current_upgrade == 0:
		if Global.Secondary_type == Global.Secondary.Grenade:
			$secondary_label/RichTextLabel.text = ("+ Increase damage by 30")
		elif Global.Secondary_type == Global.Secondary.Sentry:
			$secondary_label/RichTextLabel.text = ("+ Increase rate of fire by 0.25 seconds")
		elif Global.Secondary_type == Global.Secondary.Stun_gun:
			$secondary_label/RichTextLabel.text = ("+ increase the stun size by double")
	elif Global.Player_level >= 2 && current_upgrade == 1:
		if Global.Secondary_type == Global.Secondary.Grenade:
			$secondary_label/RichTextLabel.text = ("+ explodes 75% sooner\n_ has 20% less explosion size")
		elif Global.Secondary_type == Global.Secondary.Sentry:
			$secondary_label/RichTextLabel.text = ("+ increase rate of fire by 0.25\n_ decrease damage by 10")
		elif Global.Secondary_type == Global.Secondary.Stun_gun:
			$secondary_label/RichTextLabel.text = ("+ increase stun duration by 1 second\n_ decrease stun size by 50%")
	elif Global.Player_level >= 3 && current_upgrade == 2:
		if Global.Secondary_type == Global.Secondary.Grenade:
			$secondary_label/RichTextLabel.text = ("+ increase damage size by 50%\n_ decrease explosion size by 25%")
		elif Global.Secondary_type == Global.Secondary.Sentry:
			$secondary_label/RichTextLabel.text = ("+ 20% extra player damage\n+ 20% extra player rate of fire\n_ -10% damage from sentry")
		elif Global.Secondary_type == Global.Secondary.Stun_gun:
			$secondary_label/RichTextLabel.text = ("+ range increased by 20%\n+ stun size increased by 25%\n_ rate of fire decreased by 10%")
	secondary_option = 2

func _on_confirm_pressed():
	if primary_option != 0 && secondary_option != 0:
		if Global.Player_level >= 1 && current_upgrade == 0:
			if Global.Gun_type == Global.Gun.Shotgun:
				if primary_option == 1:
					Global.Delay -= 0.2
				elif primary_option == 2:
					Global.Mag += 2
			elif Global.Gun_type == Global.Gun.Submachine_gun:
				if primary_option == 1:
					Global.Damage += 20
				elif primary_option == 2:
					Global.Spread -= 0.05
			elif Global.Gun_type == Global.Gun.Marksman_rifle:
				if primary_option == 1:
					Global.pierce += 2
				elif primary_option == 2:
					Global.Delay -= 0.25
			if Global.Secondary_type == Global.Secondary.Grenade:
				if secondary_option == 1:
					Global.Grenade_size *= 125/100
				elif secondary_option == 2:
					Global.Grenade_damage += 30
			elif Global.Secondary_type == Global.Secondary.Sentry:
				if secondary_option == 1:
					Global.Sentry_damage += 20
				elif secondary_option == 2:
					Global.Sentry_delay -= 0.25
			elif Global.Secondary_type == Global.Secondary.Stun_gun:
				if secondary_option == 1:
					Global.stun_duration *= 3
				elif secondary_option == 2:
					Global.Stun_size *= 2
		elif Global.Player_level >= 2 && current_upgrade == 1:
			if Global.Gun_type == Global.Gun.Shotgun:
				if primary_option == 1:
					Global.Bps += 2
					Global.Delay += 0.5
				elif primary_option == 2:
					Global.Delay -= 0.3
					Global.Bps -= 2
			elif Global.Gun_type == Global.Gun.Submachine_gun:
				if primary_option == 1:
					Global.pierce += 1
					Global.Ammo -= 40
				elif primary_option == 2:
					Global.Damage += 30
					Global.Delay += 0.2
			elif Global.Gun_type == Global.Gun.Marksman_rifle:
				if primary_option == 1:
					Global.Ammo += 40
					Global.Delay += 0.5
				elif primary_option == 2:
					Global.bullet_size *= 150/100
					Global.Spread += 0.02
			if Global.Secondary_type == Global.Secondary.Grenade:
				if secondary_option == 1:
					Global.Grenade_stuns = true
					Global.stun_duration = 0.5
					Global.Grenade_damage -= 50
				elif secondary_option == 2:
					Global.Grenade_fuse *= 75/100
					Global.Grenade_size *= 80/100
			elif Global.Secondary_type == Global.Secondary.Sentry:
				if secondary_option == 1:
					Global.Sentry_damage += 30
					Global.sentry_despawn *= 50/100
				elif secondary_option == 2:
					Global.Sentry_delay -= 0.25
					Global.Sentry_damage -= 10
			elif Global.Secondary_type == Global.Secondary.Stun_gun:
				if secondary_option == 1:
					Global.stun_damage += 20
					Global.stun_duration -= 0.3
				elif secondary_option == 2:
					Global.stun_duration += 1
					Global.Stun_size *= 50/100
		elif Global.Player_level >= 3 && current_upgrade == 2:
			if Global.Gun_type == Global.Gun.Shotgun:
				if primary_option == 1:
					Global.Spread -= 0.05
					Global.pierce += 2
					Global.Delay += 0.5
				elif primary_option == 2:
					Global.Delay -= 0.2
					Global.bullet_size *= 150/100
					Global.Ammo *= 75/100
			elif Global.Gun_type == Global.Gun.Submachine_gun:
				if primary_option == 1:
					Global.Delay /= 2
					Global.Damage *= 80/100
				elif primary_option == 2:
					Global.Mag *= 120/100
					Global.Ammo += 100
					Global.delay += 0.05
			elif Global.Gun_type == Global.Gun.Marksman_rifle:
				if primary_option == 1:
					Global.pierce += 2
					Global.Mag -= 2
				elif primary_option == 2:
					Global.delay *= 50/100
					Global.Ammo *= 80/100
			if Global.Secondary_type == Global.Secondary.Grenade:
				if secondary_option == 1:
					Global.Grenade_size *= 150/100
					Global.Grenade_damage *= 75/100
				elif secondary_option == 2:
					Global.Grenade_size *= 75/100
					Global.Grenade_damage *= 150/100
			elif Global.Secondary_type == Global.Secondary.Sentry:
				if secondary_option == 1:
					Global.sentry_double_range = true
					Global.Sentry_delay *= 80/100
				elif secondary_option == 2:
					Global.Damage *= 120/100
					Global.Delay *= 80/100
					Global.Sentry_damage *= 80/100
			elif Global.Secondary_type == Global.Secondary.Stun_gun:
				if secondary_option == 1:
					Global.stun_delay *= 50/100
					Global.Stun_size *= 75/100
				elif secondary_option == 2:
					Global.stun_duration *= 120/100
					Global.Stun_size *= 125/100
					Global.stun_delay *= 110/100
		current_upgrade += 1
		primary_option = 0
		secondary_option = 0
		Global.money -= 20



func _on_heal_pressed():
	Global.health += 5
	Global.money -= 10


func _on_restock_pressed():
	Global.Ammo_left += Global.Ammo/2
	Global.money -= 30
	Global.message.play("restock")
	if Global.Ammo_left > Global.Ammo:
		Global.Ammo_left = Global.Ammo

