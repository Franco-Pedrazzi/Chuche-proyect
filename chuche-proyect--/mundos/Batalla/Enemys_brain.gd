extends Sprite2D
@onready var parent=self.get_parent()
var attacks
var Name="evilNpc"
var Attacks=[]
func _ready() -> void:
	Name=Global_ToFight.EnemyName[0].split(".")
	Name=Name[0]
	attacks=Global_ToFight.EnemysStats[Name].Attacks
	
	for Attack in Global_ToFight.EnemysStats[Name].Attacks:
		Attacks.append(Attack)
func _process(delta: float) -> void:
	if parent.turn=="Enemy":
		parent.EnemyLive-=parent.PlayerAttack.damage
		parent.turn="Player"
		print("EnemyLive: ",parent.EnemyLive)
		await get_tree().create_timer(0.5).timeout
		if parent.EnemyLive<=0:
			var mapName=GameState.mapa_actual[1]
			GameState.mapas_estado[mapName].enemigos_derrotados.append(Global_ToFight.EnemyName[1])
			Global_ToFight.EnemyName=[]
			get_tree().change_scene_to_file(GameState.mapa_actual[0])
		
		parent.EnemytAttack=Global_ToFight.EnemysStats[Name]["Attacks"][Attacks[randi_range(0,len(Attacks)-1)]]
	
