extends Control

var Select_button=""
var buttons=[]
func _ready() -> void:
	for button in self.get_children():
		buttons.append(button)
	Select_button=buttons[0].name
func _physics_process(delta: float) -> void:
	var directionY := Input.get_axis("up", "down")
	#Si se da que directionY es 1 o -1, pone la velocidad en la direccion dada
	if directionY:
		var newPosition=buttons.find(Select_button)+directionY
		
		buttons[buttons.find(Select_button)].play("default")
		if newPosition==len(buttons):
			newPosition=0
			
		if newPosition==-1:
			newPosition=len(buttons)-1
		print(buttons.find(Select_button))
		Select_button=buttons[newPosition].name
		buttons[newPosition].play("Select")
		
	
