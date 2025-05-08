extends Node

var player_position = Vector2(-100000000000,0)
var mapa_actual = []
var folder_node = "res://mundos/Maps/"
var mapas_estado = {}

func _ready() -> void:
	var dir := DirAccess.open(folder_node)
	if dir:
		for file_name in dir.get_files():
			if file_name.ends_with(".tscn"):
				file_name=file_name.split(".")[0]
				mapas_estado[file_name] = {
		"enemigos_derrotados": [],
		"cofres_abiertos": [],
		"interruptores_activados": []
	}  

	print(mapas_estado)
