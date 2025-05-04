extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
@export var type = "player"
@export var die=false
@export var defaultSPEED = 100
var SPEED = defaultSPEED

func _ready() -> void:
	if GameState.player_position != Vector2(-100000000000,0):
		position = GameState.player_position
		GameState.player_position = Vector2(-100000000000,0)

func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = moveDirection * SPEED

func _physics_process(delta):
	handleInput()
	play_anim()
	move_and_slide()

func play_anim():
	if velocity.length() == 0:
		anim.stop()
	else:
		var direction = "down"
		
		if velocity.x > 0 and velocity.y > 0: direction = "down_right"
		elif velocity.x < 0 and velocity.y > 0: direction = "down_left"
		elif velocity.x > 0 and velocity.y < 0: direction = "up_right"
		elif velocity.x < 0 and velocity.y < 0: direction = "up_left"
		elif velocity.y > 0: direction = "down"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"
		elif velocity.x < 0: direction = "left"
		
		SPEED=defaultSPEED
		anim.play("walk_" + direction)
			
		if direction in ["up-left", "up-right", "down_left", "down_right"]:
			SPEED=sqrt((defaultSPEED**2)/2)


func _on_interaction_area_body_entered(body):
	if "type" in body and body != self:
		if "" in body:
			pass
