extends Node2D
@onready var cutscene=$BattelTransition
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	cutscene.queue_free()
