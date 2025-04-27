extends CharacterBody2D

@export var DamageType = "normalDamage"
@export var action = "terminada"
@export var type = "evilNpc"

@onready var animations = $AnimationPlayer

var targetPlayer = null
var esperar = false
var SPEED = 2.5
var isColliding = false
var isMoving = true
var move = Vector2.ZERO
var stop=false
func _physics_process(delta: float) -> void:
	
	#Si tiene su objetivo definido, va a caminar en direccion a este
	if targetPlayer != null and esperar == false and isMoving:
		move=position.direction_to(targetPlayer.position)
		
	else:
		move = Vector2.ZERO
	
	move = move.normalized()*SPEED
	move = move_and_collide(move)
		
	move_and_slide()
	


#Chequea si el jugador entro en el area de deteccion
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != self and "type" in body:
		if body.type == "player":
			targetPlayer = body
			animations.play("walk")
func _on_area_2d_2_body_entered(body):
	Global_ToFight.EnemyName="evilNpc.jpeg"
	get_tree().change_scene_to_file("res://mundos/Batalla/Battalla.tscn")

func _on_interaction_area_body_exited(body: Node2D) -> void:
	stop = true
	isColliding = false
