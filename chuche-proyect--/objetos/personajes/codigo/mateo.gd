extends CharacterBody2D
@export var lives=3
@export var type="jugador"
var stop=false
var SPEED=300
var notStop=true
var unidos=false
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
		
	move_and_slide()


func _on_interaction_area_body_entered(body):
	stop=false
	unidos=true
	if "type" in body:
		if body.type=="daño":
			await get_tree().create_timer(0.27).timeout
			print(body.action)
			if body.action=="efectivo" and stop==false:
				lives-=1
				var direccion=body.position-position
				direccion.x/=abs(direccion.x)
				direccion.y/=abs(direccion.y)
				velocity= Vector2i(direccion.x * 180*-1,direccion.y* 180*-1)
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
