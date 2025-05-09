extends Node
var evilNpc=Enemy.new()

func _ready():
	evilNpc.name = "evilNpc"
	evilNpc.life = 100
	evilNpc.attacks = {
		"punch": LoadEnemysAttacks.punch,
		"kick": LoadEnemysAttacks.kick
	}
	evilNpc.abilitys = {}



	
