extends CharacterBody2D
@export var type="daño"
var jugador=null
var jugadorAux=null
var SPEED=2.5
@onready var animations=$AnimationPlayer
var move=Vector2.ZERO
func _physics_process(delta: float) -> void:
	if jugador!=null:
		move=position.direction_to(jugador.position)
	else:
		move=Vector2.ZERO
	move=move.normalized()*SPEED
	move=move_and_collide(move)
	move_and_slide()
	



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body!=self:
		jugador=body
		jugadorAux=body
		animations.play("caminar")


func _on_area_2d_2_body_entered(body):
	animations.play("pegar")
	velocity.y = move_toward(velocity.y, 0, SPEED)
	velocity.x = move_toward(velocity.x, 0, SPEED)
	jugador=null
	await get_tree().create_timer(0.2).timeout
	animations.play("default")
	await get_tree().create_timer(0.05).timeout
	jugador=jugadorAux
	
