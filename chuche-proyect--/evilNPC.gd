extends CharacterBody2D
var jugador=null
var SPEED=2.5
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
