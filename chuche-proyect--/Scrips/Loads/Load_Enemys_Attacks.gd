extends Node

var punch=Attack.new()
var kick = Attack.new()
func _ready() -> void:
	
	punch.name = "punch"
	punch.damage = 10
	punch.consecutive_attacks = 2
	punch.areas = ["left", "center", "right"]

	kick.name = "kick"
	kick.damage = 20
	kick.areas = ["center", "down"]
