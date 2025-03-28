extends CharacterBody2D

@export var type="dañoInsta"
@export var vel=Vector2i(0,0)
@export var jugador=null
var move=Vector2.ZERO
var SPEED=250
var rot:float
var time=3

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)  # Mueve hacia la rotación actual
	velocity = direction * SPEED  # Aplica la velocidad

	move_and_slide()
	
func _on_interaction_area_body_entered(body: Node2D) -> void:
	queue_free()
