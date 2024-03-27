extends Node


var Player: CharacterBody2D
enum Gun {Shotgun, Submachine_gun, Marksman_rifle}
enum Secondary {Grenade, Sentry, Stun_gun}
var Gun_type = null
var Secondary_type = null

#is player touching the shop
var Touching_shop = false

#message animator
var message: AnimationPlayer

#player level
var Score = 0
var Player_level = 0

#current loaded level
var Level = 0

#amount of crystals
var money = 0

#health
var health:int = 25

#can the player shoot
var can_shoot = true

#is HUD visible
var HUD_visible = true

#spawning positions
var Spawn_pos = Vector2(0, 0)

#difficulty
var difficulty = 1
var difficulty_time = 3

#sentry
var Sentry_damage = 50
var Sentry_pierce = 1
var Sentry_delay = 0.75
var sentry_despawn = 1
var sentry_double_range =  false

#grenade
var Grenade_damage = 150
var Grenade_size = 1
var Grenade_stuns = false
var Grenade_fuse = 1.5

#stun gun
var Stun_gun_pierce = 1
var Stun_size = 1
var stun_despawn = 0.1
var stun_duration = 1
var stun_damage = 0
var stun_delay = 2

#guns
var Speed = 0
var Ammo = 0
var Mag = 0
var Spread = 0
var Delay = 0
var Reload = 0
var Damage = 0
var Bps = 0
var Hold = null
var pierce = 0
var despawn = 1
var bullet_size = 1

var Ammo_left
