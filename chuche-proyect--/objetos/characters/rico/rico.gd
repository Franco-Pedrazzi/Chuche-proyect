extends CharacterBody2D

@export var lives = 3
@export var type = "player"
@export var attacking = false
#@onready var animations = $AnimationPlayer
@onready var anim = $AnimatedSprite2D
var SPEED = 100
var currentDir = "none"

var canReceiveDamage = false
var isMoving = true
var isColliding = false

func _physics_process(delta):
	
	#Recibe el input del jugador y puede ser 1 (derecha), -1 (izquierda) o null
	var directionX := Input.get_axis("left", "right")
	
	#Si se da que directionX es 1 o -1, pone la velocidad en la direccion dada
	if directionX and isMoving:
		velocity.x = directionX * SPEED
	
	elif isMoving:
		#Si no recibe input y se encuentra en movimiento, reduce la velocidad hasta llegar a 0
		velocity.x = move_toward(velocity.x, 0, SPEED/3)
	
	#Recibe el input del jugador y puede ser 1 (derecha) o -1 (izquierda)
	var directionY := Input.get_axis("up", "down")
	
	#Si se da que directionY es 1 o -1, pone la velocidad en la direccion dada
	if directionY and isMoving:
		velocity.y = directionY* SPEED
	elif isMoving:
		#Si no recibe input y se encuentra en movimiento, reduce la velocidad hasta llegar a 0
		velocity.y = move_toward(velocity.y, 0, SPEED/3)

	#Si se toca el boton de pegar, se declara la animacion como pegar
	#y attacking como true, y despues vuelve a la normalidad
	if Input.is_action_just_pressed("attack"):
		#animations.play("attack")
		attacking=true
		await get_tree().create_timer(0.27).timeout
		#animations.play("idle")
		attacking=false
	
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
	#Chequea cuando se entra en contacto con un cuerpo
	
	#Estado por default
	canReceiveDamage=false
	isColliding = true
	
	#Cheque si el cuerpo en el que se esta en contacto es diferente al de Rico
	#y si la propiedad "type" existe en el cuerpo (player, enemigo, bullet,etc)
	if "type" in body and body != self:

		if "DamageType" in body and !attacking:
			
			if body.DamageType=="normalDamage" or body.DamageType=="instantDamage":
				
				if body.DamageType!="instantDamage":
					await get_tree().create_timer(0.27).timeout
					
				if canReceiveDamage == false and not attacking:
					canReceiveDamage = true
					lives -= 1
					
					
					var angle=(body.position - position).angle()
					
					var direction = Vector2.RIGHT.rotated(angle)  # Mueve hacia la rotación actual
					velocity = direction * SPEED*-1
					
					#Paraliza
					isMoving = false
					await get_tree().create_timer(0.25).timeout
					isMoving = true
					
				#Chequea si se acabaron las vidas para recargar la escena actual
				#Simulando un GAME OVER
				if lives <= 0:
					get_tree().reload_current_scene()
					return #Me parece que no hace falta el return?
				
		await get_tree().create_timer(0.25).timeout
		
		if isColliding == true:
			_on_interaction_area_body_entered(body)


func _on_interaction_area_body_exited(body: Node2D) -> void:
	canReceiveDamage = true
	isColliding = false
