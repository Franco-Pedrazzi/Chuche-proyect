extends Control
var directionY = 0
var Select_button=""
var buttons=[]

func _ready() -> void:
	for button in self.get_children():
		buttons.append(button)
	Select_button=buttons[0]
func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("down"):
		directionY=1
	if Input.is_action_just_released("up"):
		directionY=-1
	#Si se da que directionY es 1 o -1, pone la velocidad en la direccion dada
	if directionY:
		var newPosition=buttons.find(Select_button)+directionY
		
		buttons[buttons.find(Select_button)].play("default")
		if newPosition==len(buttons):
			newPosition=0
			
		if newPosition==-1:
			newPosition=len(buttons)-1
		Select_button=buttons[newPosition]
		buttons[newPosition].play("Select")
		directionY=0
		
	if Input.is_action_just_released("acttion"):
		var AtackOptions = preload("res://objetos/interfas/battel/Fight.tscn")
		AtackOptions=AtackOptions.instantiate()
		AtackOptions.position=Vector2i(50,-15)
		AtackOptions.scale.x=0.5
		AtackOptions.scale.y=0.5
		add_child(AtackOptions)
	
