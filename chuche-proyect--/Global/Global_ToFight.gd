extends Node

#Enemy data
var EnemyName=["evilNpc.jpeg","EvilGodot"]
var Attacks={
	"Punch":["left","center","right"],
	"Kick":["center","down"],
	"Gun":["all"]
		}
var EnemysStats={
	"evilNpc":{
		"Live":100,
 		"Attacks":{
			"Punch":{"damage":10,"consecutiveAttacks":2},
			"Kick":{"damage":20,"consecutiveAttacks":1}
				}
	}
	
	
}


#Player data
var PlayerLive=100
var PlayersAttacks={
	"Punch":10,
	"Kick":20,
	"Spoon":30
}

var PlayersActions={
	"Hablar":10,
	"Putear":20,
	"Nicolo":30
}

var PlayersItems={
	"Lapiz":["escribe","descripcion",12],
	"Cuchara":["cucharear","descripcion",1],
	"queso":["curar","descripcion",0.2]
}
