extends Control
var directionY = 0
var Select_button=""
var activateMenu=0
var MenusButtons=[[]]

func CreateMenu(Action):
	var Options = preload("res://objetos/interfas/battel/Fight.tscn")
	Options=Options.instantiate()
	Options.position=Vector2i(50,25)
	Options.scale.x=0.5
	Options.scale.y=0.5
	Options.ActionName=Action
	add_child(Options)

func _ready() -> void:
	for button in self.get_children():
		MenusButtons[0].append(button)
	Select_button=MenusButtons[0][0]
	MenusButtons.append([])
	for button in Global_ToFight.PlayersAttacks:
		MenusButtons[1].append(button)
	MenusButtons.append([])
	for button in Global_ToFight.PlayersActions:
		MenusButtons[2].append(button)
	MenusButtons.append([])
	for button in Global_ToFight.PlayersItems:
		MenusButtons[3].append(button)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("down"):
		directionY=1
	if Input.is_action_just_pressed("up"):
		directionY=-1
		
	#Si se da que directionY es 1 o -1, pone la velocidad en la direccion dada
	if directionY:
		var newPosition=MenusButtons[activateMenu].find(Select_button)+directionY
		if activateMenu==0:
			MenusButtons[activateMenu][MenusButtons[activateMenu].find(Select_button)].play("default")
		else:
			var Fight_Menu=$Fight_Menu/TextboxContainer/MarginContainer/OptionsConteiner
			var options=Fight_Menu.get_children()
			options[MenusButtons[activateMenu].find(Select_button)].add_theme_color_override("font_color", Color(255,255,255,255))
		
		if newPosition==len(MenusButtons[activateMenu]):
				newPosition=0
			
		if newPosition==-1:
			newPosition=len(MenusButtons[activateMenu])-1
		Select_button=MenusButtons[activateMenu][newPosition]
		if activateMenu==0:
			MenusButtons[activateMenu][newPosition].play("Select")
		else:
			var Fight_Menu=$Fight_Menu/TextboxContainer/MarginContainer/OptionsConteiner
			var options=Fight_Menu.get_children()
			options[newPosition].add_theme_color_override("font_color", Color(255,255,0,255))
	directionY=0
		
	if Input.is_action_just_pressed("acttion") and Select_button.name=="Fight" and activateMenu==0:
		CreateMenu("PlayersAttacks")
		Select_button={"name":""}
		activateMenu=1
		
	if Input.is_action_just_pressed("acttion") and Select_button.name=="Act" and activateMenu==0:
		CreateMenu("PlayersActions")
		Select_button={"name":""}
		activateMenu=2
		
	if Input.is_action_just_pressed("acttion") and Select_button.name=="Item" and activateMenu==0:
		CreateMenu("PlayersItems")
		Select_button={"name":""}
		activateMenu=3
		

	if Input.is_action_just_pressed("Cancel") and activateMenu!=0:
		var Fight_Menu=$Fight_Menu
		self.remove_child(Fight_Menu)
		Select_button=MenusButtons[0][activateMenu-1]
		activateMenu=0
