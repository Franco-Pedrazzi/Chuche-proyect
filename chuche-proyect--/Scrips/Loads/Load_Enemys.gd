extends Node
var evilNpc=Enemy.new()

func _ready():
	evilNpc.name = "evilNpc"
	evilNpc.life = 100
	evilNpc.attacks = {
		"Punch": LoadEnemysAttacks.punch,
		"Kick": LoadEnemysAttacks.kick
	}
	evilNpc.abilitys = {}



	
