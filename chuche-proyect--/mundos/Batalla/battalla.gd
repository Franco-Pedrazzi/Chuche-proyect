extends Node2D
@onready var cutscene=$BattelTransition
@onready var EnemyBarLive=$EnemyLive
@onready var PlayerBarLive=$PlayerLive
var EnemyPath="res://sprites/characters/EvilNpcs/evilNpc"
var Enemy= Sprite2D.new()
var EnemyLive=100
#player
@export var PlayerAttack=0
#enemy
@export var EnemytAttack=0
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
	EnemyLive=Global_ToFight.EnemysStats[Global_ToFight.EnemyName[0].split(".")[0]].Live
	
func _process(delta: float) -> void:
	EnemyBarLive.size.x=EnemyLive
	PlayerBarLive.size.x=Global_ToFight.PlayerLive
