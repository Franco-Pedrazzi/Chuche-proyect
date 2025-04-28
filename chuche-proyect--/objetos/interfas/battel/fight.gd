extends Node2D
@export var ActionName=""
var Actions
@onready var OptionsConteiner=$TextboxContainer/MarginContainer/OptionsConteiner
var count=0
func _ready() -> void:
	Actions= Global_ToFight[ActionName]
	for action in Actions:
		var button=Label.new()
		button.text=action
		var font = load("res://fonts/BodgeR.ttf")
		button.add_theme_font_override("font", font)
		button.add_theme_font_size_override("font_size", 20)
		button.position=Vector2i(10,count*100)
		if count==0:
			button.add_theme_color_override("font_color", Color(255,255,0,255))
		else:
			button.add_theme_color_override("font_color", Color(255,255,255,255))
		OptionsConteiner.add_child(button)
		count+=1
		

	
		
		
