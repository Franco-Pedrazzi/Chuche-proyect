extends CharacterBody2D
@export var type="daño"
@export var action="terminada"
var jugador=null
var esperar=false
var SPEED=2.5
var unidos=false
@onready var animations=$AnimationPlayer
var move=Vector2.ZERO
func _physics_process(delta: float) -> void:
	if jugador!=null and esperar==false:
		move=position.direction_to(jugador.position)
	else:
		move=Vector2.ZERO
	move=move.normalized()*SPEED
	move=move_and_collide(move)
	move_and_slide()
	



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body!=self and "type" in body:
		if body.type=="jugador":
			jugador=body
			animations.play("caminar")


func _on_area_2d_2_body_entered(body):
	if body==jugador:
		animations.play("pegar")
		esperar=true
		unidos=true
		await get_tree().create_timer(0.2).timeout
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
	unidos=false
