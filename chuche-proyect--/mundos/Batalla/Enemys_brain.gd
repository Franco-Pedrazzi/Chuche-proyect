extends Sprite2D
@onready var parent=self.get_parent()
var attacks
var Name="evilNpc"
var Attacks=[]
var Oponent={}

func _ready() -> void:
	Name=Global_ToFight.EnemyName[0].split(".")
	Name=Name[0]
	Oponent=LoadEnemys[Name]
	attacks=Oponent.attacks
	
	for attack in attacks:
		Attacks.append(attack)
func _process(delta: float) -> void:
	if parent.turn=="Enemy":
		parent.EnemyLive-=parent.PlayerAttack.damage
		parent.turn="EnemyAttack"
		await get_tree().create_timer(0.5).timeout
		if parent.EnemyLive<=0:
			var mapName=GameState.mapa_actual[1]
			GameState.mapas_estado[mapName].enemigos_derrotados.append(Global_ToFight.EnemyName[1])
			Global_ToFight.EnemyName=[]
			get_tree().change_scene_to_file(GameState.mapa_actual[0])
		
		parent.EnemytAttack=LoadEnemys[Name]["attacks"][Attacks[randi_range(0,len(Attacks)-1)]].damage
		parent.turn="Player"
