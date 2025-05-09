extends Sprite2D

@onready var parent = self.get_parent()
var attacks
var Name = "evilNpc"
var Attacks = []
var Oponent = {}
var combo = 1
var AtaquesCombinados = 0
var attack = ""
var busy = false  # evita múltiples ejecuciones simultáneas

func _ready() -> void:
	Name = Global_ToFight.EnemyName[0].split(".")[0]
	Oponent = LoadEnemys[Name]
	attacks = Oponent.attacks
	for atk in attacks:
		Attacks.append(atk)

func _process(_delta: float) -> void:
	# Solo entra si no está ocupado y es el turno del enemigo
	if not busy and (parent.turn == "Enemy" or parent.turn == "EnemyAttack"):
		busy = true
		start_Turn()  # No necesita await aquí

func start_Turn() -> void:
	await get_tree().create_timer(0.5).timeout
	
	if parent.turn == "Enemy":
		parent.EnemyLive -= parent.PlayerAttack.damage
		if parent.EnemyLive <= 0:
			var mapName = GameState.mapa_actual[1]
			GameState.mapas_estado[mapName].enemigos_derrotados.append(Global_ToFight.EnemyName[1])
			Global_ToFight.EnemyName = []
			get_tree().change_scene_to_file(GameState.mapa_actual[0])
			return

		parent.turn = "EnemyAttack"
		attack = Attacks[randi_range(0, Attacks.size() - 1)]
	
	await enemy_attack()

func enemy_attack() -> void:
	if parent.turn != "EnemyAttack":
		busy = false
		return

	if AtaquesCombinados < Oponent.combo:
		var area = LoadEnemys[Name]["attacks"][attack]["areas"][randi_range(0, LoadEnemysAttacks[attack].areas.size() - 1)]
		parent.EnemytAttack = [attack, area, LoadEnemys[Name]["attacks"][attack].damage]
		AtaquesCombinados += 1
		print("Ataque:", attack)

		# Verifica combo
		if combo < LoadEnemysAttacks[attack].consecutive_attacks:
			await get_tree().create_timer(0.5).timeout
			combo += 1
		else:
			await get_tree().create_timer(1.0).timeout
			combo = 1
		
		# Prepara el próximo ataque
		attack = Attacks[randi_range(0, Attacks.size() - 1)]

		# Repite el ataque
		await enemy_attack()
	else:
		# Fin del turno enemigo
		parent.EnemytAttack = [""]
		parent.turn = "Player"
		AtaquesCombinados = 0
		busy = false
