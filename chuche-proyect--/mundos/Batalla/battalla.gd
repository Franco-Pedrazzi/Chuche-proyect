extends Node2D
@onready var cutscene=$BattelTransition
var EnemyPath="res://sprites/characters/EvilNpcs/evilNpc"
var Enemy= Sprite2D.new()
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	cutscene.queue_free()
	EnemyPath="res://sprites/characters/EvilNpcs/"+Global_ToFight.EnemyName
	Enemy.texture = load(EnemyPath)
	Enemy.position=Vector2i(350,120)
	Enemy.scale.x=0.5
	Enemy.scale.y=0.5
	add_child(Enemy)
	
