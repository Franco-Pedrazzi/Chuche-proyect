extends Node2D
var Attacks= Global_ToFight.PlayersAttacks
@onready var MarginCner=$TextboxContainer/MarginContainer
var count=0
func _ready() -> void:
	for attack in Attacks:
		print(count*75-75)
		var button=Label.new()
		button.text=attack
		button.position=Vector2i(10,count*75-75)
		MarginCner.add_child(button)
		count+=1
	
		
		
