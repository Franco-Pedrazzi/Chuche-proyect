extends CharacterBody2D
var jugador=null
var SPEED=2.5
@onready var animations=$AnimationPlayer
var move=Vector2.ZERO
var scapeTime=false
var startShoot=false

func _physics_process(delta: float) -> void:
	if startShoot:
		startShoot=false
		cargar()
	if jugador!=null:
		if scapeTime:
			var distanceX=(position.x-jugador.position.x)
			var distanceY=(position.y-jugador.position.y)
			var directionX=distanceX/distanceX
			var directionY=distanceY/distanceY
			move=position.direction_to(Vector2i(position.x+directionX*distanceX,position.y+directionY*distanceY))
		
		else:
			if abs(position.x-jugador.position.x)-118<1 and abs(position.y-jugador.position.y)-118<1:
				move=Vector2.ZERO
				animations.play("default")
			else:
				move=position.direction_to(jugador.position)
				
	else:
		move=Vector2.ZERO
			
	move=move.normalized()*SPEED
	move=move_and_collide(move)
	move_and_slide()
func cargar():
	print("shic")
	animations.play("pegar")
	if jugador!=null:
		if "lives" in jugador:
			if jugador.lives>0:
				await get_tree().create_timer(3).timeout
				cargar()
	
func disparar():
	var bullet_scene = preload("res://objetos/items/bullet/bullet.tscn")
	var bullet = bullet_scene.instantiate()
	var angle = (jugador.position - position).angle()
	bullet.jugador = jugador  
	bullet.position = position  
	bullet.rotation = angle
	get_parent().add_child(bullet)
	print("bang")


func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body!=self and "type" in body and jugador==null:
		if body.type=="jugador":
			jugador=body
			animations.play("caminar")

func _on_distance_body_entered(body: Node2D) -> void:
	if body!=self and "type" in body:
		if body.type=="jugador":
			scapeTime=true
			await get_tree().create_timer(2).timeout
			animations.play("pegar")
			
func _on_distance_body_exited(body: Node2D) -> void:
	if body!=self and "type" in body:
		if body.type=="jugador":
			scapeTime=false
			


func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body!=self and "type" in body:
		if body.type=="jugador":
			startShoot=true
