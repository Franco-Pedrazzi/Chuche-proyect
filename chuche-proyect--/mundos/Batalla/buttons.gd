extends Control
var directionY = 0
var Select_button=""
var activateMenu=0
var MenusButtons=[[]]
@onready var parent=self.get_parent()


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
		MenusButtons[1].append({"name":button,"damage":Global_ToFight.PlayersAttacks[button]})
	MenusButtons.append([])
	for button in Global_ToFight.PlayersActions:
		MenusButtons[2].append({"name":button,"Action":Global_ToFight.PlayersActions[button]})
	MenusButtons.append([])
	for button in Global_ToFight.PlayersItems:
		MenusButtons[3].append({"name":button,"damage":0,"Effec":Global_ToFight.PlayersItems[button]})

func _physics_process(delta: float) -> void:
	if parent.EnemytAttack != 0:
		Global_ToFight.PlayerLive-=parent.EnemytAttack
		parent.EnemytAttack=0
	if 	Global_ToFight.PlayerLive<=0:
		print("MATEO AAAAA")
	if Input.is_action_just_pressed("down") and parent.turn=="Player":
		directionY=1
	if Input.is_action_just_pressed("up") and parent.turn=="Player":
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
	if Input.is_action_just_pressed("acttion") and Select_button.name=="Punch":
		var Fight_Menu=$Fight_Menu
		self.remove_child(Fight_Menu)
		activateMenu=0
		parent.turn="Enemy"
		parent.PlayerAttack=Select_button
		Select_button=MenusButtons[0][0]
	
	if Input.is_action_just_pressed("acttion") and Select_button.name=="Kick":
		var Fight_Menu=$Fight_Menu
		self.remove_child(Fight_Menu)
		activateMenu=0
		parent.turn="Enemy"
		parent.PlayerAttack=Select_button
		Select_button=MenusButtons[0][0]
		
	if Input.is_action_just_pressed("acttion") and Select_button.name=="Spoon":
		var Fight_Menu=$Fight_Menu
		self.remove_child(Fight_Menu)
		activateMenu=0
		parent.turn="Enemy"
		parent.PlayerAttack=Select_button
		Select_button=MenusButtons[0][0]

	if Input.is_action_just_pressed("acttion"):
		print(Select_button)	
	
	if Input.is_action_just_pressed("acttion") and Select_button.name=="Fight" and parent.turn=="Player":
		CreateMenu("PlayersAttacks")
		Select_button=MenusButtons[1][0]
		activateMenu=1

		
	if Input.is_action_just_pressed("acttion") and Select_button.name=="Act" and parent.turn=="Player":
		CreateMenu("PlayersActions")
		Select_button=MenusButtons[2][0]
		activateMenu=2
		
	if Input.is_action_just_pressed("acttion") and Select_button.name=="Item" and parent.turn=="Player" :
		CreateMenu("PlayersItems")
		Select_button=MenusButtons[3][0]
		activateMenu=3
		

	if Input.is_action_just_pressed("Cancel") and activateMenu!=0:
		var Fight_Menu=$Fight_Menu
		self.remove_child(Fight_Menu)
		activateMenu=0
		for MenusButton in MenusButtons:
			if Select_button in MenusButton:
				Select_button=MenusButtons[0][MenusButtons.find(MenusButton)-1]
				
