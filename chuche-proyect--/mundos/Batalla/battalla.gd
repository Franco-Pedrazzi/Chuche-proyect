extends Node2D
@onready var cutscene=$BattelTransition
@onready var EnemyBarLive=$EnemyLive
@onready var PlayerBarLive=$PlayerLive
@onready var Player=$Rico
var EnemyPath="res://sprites/characters/EvilNpcs/evilNpc"
var Enemy= Sprite2D.new()
var EnemyLive=100
#player
@export var PlayerAttack=0
var areas=["center","down"]
#enemy
@export var EnemytAttack=[""]
#General
@export var turn="Player"

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	cutscene.queue_free()
	EnemyPath="res://sprites/characters/EvilNpcs/"+Global_ToFight.EnemyName[0]
	Enemy.texture = load(EnemyPath)
	Enemy.position=Vector2i(350,120)
	Enemy.scale.x=0.5
	Enemy.scale.y=0.5
	Enemy.set_script(preload("res://mundos/Batalla/Enemys_brain.gd"))
	add_child(Enemy)
	EnemyLive=LoadEnemys[Global_ToFight.EnemyName[0].split(".")[0]].life
	
func _process(delta: float) -> void:
	EnemyBarLive.size.x=EnemyLive
	PlayerBarLive.size.x=Global_ToFight.PlayerLive
	if turn=="Enemy":
		Player.position=Vector2i(150,140)
		Enemy.position=Vector2i(200,170)
		
	else:
		Enemy.position=Vector2i(350,120)
		Player.position=Vector2i(86.0,185)
		
	if	turn == "EnemyAttack":
		pass
	if 	Global_ToFight.PlayerLive<=0:
		print("MATEO AAAAA")
