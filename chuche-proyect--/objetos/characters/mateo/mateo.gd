extends CharacterBody2D
@export var lives=3
@export var type="jugador"
@export var attacking=false
@onready var animations=$AnimationPlayer
var esperar=false
var stop=false
var SPEED=300
var notStop=true
var unidos=false
var move=Vector2.ZERO

func _physics_process(delta):
		 
	var directionX := Input.get_axis("left", "right")
	if directionX and notStop:
		velocity.x = directionX * SPEED
	elif notStop:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directionY := Input.get_axis("up", "down")
	if directionY and notStop:
		velocity.y = directionY* SPEED
	elif notStop:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if Input.is_action_just_pressed("pegar"):
		animations.play("pegar")
		attacking=true
		await get_tree().create_timer(0.27).timeout
		animations.play("Itel")
		attacking=false
	move_and_slide()


func _on_interaction_area_body_entered(body):
	
	stop=false
	unidos=true
	if "type" in body and body!=self:

				
		if "DamageType" in body:
			if body.DamageType=="daño" or body.DamageType=="dañoInsta":		
				if body.DamageType=="daño":
					await get_tree().create_timer(0.27).timeout
				if stop==false:
					lives-=1
					var angle=(body.position - position).angle()
					var direction = Vector2.RIGHT.rotated(angle)  # Mueve hacia la rotación actual
					velocity = direction * SPEED*-1
				
					notStop=false
					await get_tree().create_timer(0.25).timeout
					notStop=true
				if lives<=0:
					get_tree().reload_current_scene()
					return 
		await get_tree().create_timer(0.25).timeout
		if unidos:
			_on_interaction_area_body_entered(body)


func _on_interaction_area_body_exited(body: Node2D) -> void:
	stop=true
	unidos=false
	
	
