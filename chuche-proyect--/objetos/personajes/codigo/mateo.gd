extends CharacterBody2D
@export var lives=3
var SPEED=300
var notStop=true
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


func _on_area_2d_body_entered(body):
	if "type" in body:
		if body.type=="daño":
			lives-=1
			print(lives)
		var direccion=body.position-position
		direccion.x/=abs(direccion.x)
		direccion.y/=abs(direccion.y)
		velocity= Vector2i(direccion.x * 180*-1,direccion.y* 180*-1)
		notStop=false
		await get_tree().create_timer(0.25).timeout
		notStop=true
