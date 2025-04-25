extends CharacterBody2D

@export var type = "player"

#@onready var animations = $AnimationPlayer
@onready var anim = $AnimatedSprite2D
var SPEED = 100
var currentDir = "none"


func _physics_process(delta):
	
	#Recibe el input del jugador y puede ser 1 (derecha), -1 (izquierda) o null
	var directionX := Input.get_axis("left", "right")
	
	#Si se da que directionX es 1 o -1, pone la velocidad en la direccion dada
	if directionX:
		velocity.x = directionX * SPEED
	
	else:
		#Si no recibe input y se encuentra en movimiento, reduce la velocidad hasta llegar a 0
		velocity.x = move_toward(velocity.x, 0, SPEED/3)
	
	#Recibe el input del jugador y puede ser 1 (derecha) o -1 (izquierda)
	var directionY := Input.get_axis("up", "down")
	
	#Si se da que directionY es 1 o -1, pone la velocidad en la direccion dada
	if directionY:
		velocity.y = directionY* SPEED
	else:
		#Si no recibe input y se encuentra en movimiento, reduce la velocidad hasta llegar a 0
		velocity.y = move_toward(velocity.y, 0, SPEED/3)

	
	if directionX == 1 and directionY == 1: currentDir = "down-right"
	elif directionX == -1 and directionY == 1: currentDir = "down-left"
	elif directionX == 1 and directionY == -1: currentDir = "up-right"
	elif directionX == -1 and directionY == -1: currentDir = "up-left"
	elif directionY == 1: currentDir = "down"
	elif directionX == 1: currentDir = "right"
	elif directionY == -1: currentDir = "up"
	elif directionX == -1: currentDir = "left"
	else: currentDir = "none"
	play_anim()
	
	#Se encarga de permitir continuar moviendose incluso cuando se alcanza una pared
	move_and_slide()

func play_anim():
	if currentDir == "down":
		anim.play("walk_down")
	if currentDir == "up":
		anim.play("walk_up")
	if currentDir == "right":
		anim.play("walk_right")
	if currentDir == "left":
		anim.play("walk_left")
	if currentDir == "down-right":
		anim.play("walk_down_right")
	if currentDir == "down-left":
		anim.play("walk_down_left")
	if currentDir == "up-right":
		anim.play("walk_up_right")
	if currentDir == "up-left":
		anim.play("walk_up_left")
	if currentDir == "none":
		anim.pause()


func _on_interaction_area_body_entered(body):
	if "type" in body and body != self:
		if "" in body:
			pass
	
