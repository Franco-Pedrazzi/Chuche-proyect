extends CharacterBody2D
@export var DamageType="daño"
@export var action="terminada"
@export var type="evilNpc"
var jugador=null
var esperar=false
var SPEED=2.5
var unidos=false
var stop=false
var lives=3
var notStop=true
@onready var animations=$AnimationPlayer
var move=Vector2.ZERO

func _physics_process(delta: float) -> void:

	if jugador!=null and esperar==false and notStop:
		move=position.direction_to(jugador.position)
	else:
		move=Vector2.ZERO
		
	if lives<=0:
		queue_free()
	else:
		move=move.normalized()*SPEED
		move=move_and_collide(move)
	move_and_slide()
	



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body!=self and "type" in body:
		if body.type=="jugador":
			jugador=body
			animations.play("caminar")


func _on_area_2d_2_body_entered(body):
	stop=false
	unidos=true
	if body==jugador:
		await get_tree().create_timer(0.3).timeout
		if body.attacking:		
			
			if stop==false:
				lives-=1
				var angle=(body.position - position).angle()
				var direction = Vector2.RIGHT.rotated(angle)  # Mueve hacia la rotación actual
				velocity = direction * SPEED*-1*120
				
				notStop=false
				await get_tree().create_timer(0.25).timeout
				velocity = Vector2i(0,0)
				await get_tree().create_timer(0.3).timeout
				notStop=true

		elif esperar:
			animations.play("pegar")
			esperar=true
			unidos=true
			await get_tree().create_timer(0.2).timeout
			if unidos:
				_on_area_2d_2_body_entered(body)

	await get_tree().create_timer(0.25).timeout
	if unidos:
		_on_area_2d_2_body_entered(body)



func pegar():
	action="efectivo"
	animations.play("default")
	await get_tree().create_timer(0.2).timeout
	action="terminada"
	await get_tree().create_timer(0.75).timeout
	esperar=false
	
func _on_interaction_area_body_exited(body: Node2D) -> void:
	stop=true
	unidos=false
