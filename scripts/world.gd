extends Node2D

#variables
var spawn_pos = Vector2(0,0)
var enemies_left = 0

#if level needs to change
var change = false

#scenes to refrence
var enemy = preload("res://scenes/enemy.tscn")
var coin = preload("res://scenes/coin.tscn")
var level_1 = preload("res://scenes/level_1.tscn")
var level_2 = preload("res://scenes/level_2.tscn")
var spawnable = false

#animations played?
var played1 = false
var played2 = false
var played3 = false

#set the global variable for the player
func _ready():
	Global.Player = $Character
	Global.Level = 1
	Global.HUD_visible = true
	change = true
	$fade_backup.visible = false
	$AnimationPlayer.play("fade_in")
	


func _process(delta):
	#moving the black circle for level change to players position
	$fade_circle.position = $Character.position
	
	#camera position
	$Camera2D.position = Global.Player.position
	
	#player leveling
	if Global.Score >= 200:
		Global.Player_level = 3
		if played1 == false:
			played1 = true
			Global.message.play("levelup")
	elif Global.Score >= 75:
		Global.Player_level = 2
		if played2 == false:
			played2 = true
			Global.message.play("levelup")
	elif Global.Score >= 30:
		Global.Player_level = 1
		if played3 == false:
			played3 = true
			Global.message.play("levelup")
	
	#open shop if player is touching it
	if Input.is_action_just_pressed("interact"):
		if Global.Touching_shop == true && $CanvasLayer/Upgrades.visible == false:
			$CanvasLayer/Upgrades.visible = true
			Global.can_shoot = false
		elif $CanvasLayer/Upgrades.visible == true:
			$CanvasLayer/Upgrades.visible = false
			Global.can_shoot = true
	
	if Input.is_action_just_pressed("Escape"):
		$"CanvasLayer/are you sure".visible = true
	
	#changing the difficulty over time
	Global.difficulty = Global.difficulty_time / 3
	
	#changing level
	if change == true:
		change = false
		if Global.Level == 1:
			var level = level_1.instantiate()
			add_child(level)
		elif Global.Level == 2:
			var level = level_2.instantiate()
			add_child(level)
			$AnimationPlayer.play("fade_in")
			$fade_backup.visible = false
			Global.HUD_visible = true
			await get_tree().create_timer(2).timeout
			spawnable = true

#spawning enemies and chaning the time between spawns
func _on_spawn_timer_timeout():
	if Global.Level == 2 && spawnable == true:
		spawn_pos = $level_2/spawn_pos.position + Vector2(0,randf_range(-16,16))
		enemies_left = randi_range(1,5) * Global.difficulty
		$spawn_timer.wait_time = randf_range(20,30) / Global.difficulty
		while enemies_left > 0:
			var Enemy = enemy.instantiate()
			add_child(Enemy)
			Enemy.position = (spawn_pos)
			Enemy.died.connect(_on_enemy_died)
			enemies_left -= 1

#coin spawning
func _on_enemy_died(pos):
	var Coin = coin.instantiate()
	add_child(Coin)
	Coin.position = (pos)
	Global.Score += 1

#difficulty increase
func _on_difficulty_timeout():
	Global.difficulty_time += 0.1


func _on_progress_body_entered(body):
	if body.is_in_group("character"):
		$AnimationPlayer.play("fade_out")
		await get_tree().create_timer(0.3).timeout
		Global.HUD_visible = false
		await get_tree().create_timer(1).timeout
		$fade_backup.visible = true
		Global.Player.position = Vector2(-20,0)
		$Camera2D.position = Vector2(-20,0)
		await get_tree().create_timer(0.3).timeout
		$Level_1.queue_free()
		$StaticBody2D.queue_free()
		$progress.queue_free()
		Global.Level = 2
		change = true


