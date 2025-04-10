extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var dialogue = $TextboxContainer/MarginContainer/Dialogue
@onready var animation = $AnimationPlayer

func _ready():
	hide_textbox()
	show_textbox()
	add_text("Tenemos que acabar\ncon este Chuche!")

func hide_textbox():
	dialogue.text = ""
	textbox_container.hide()
	
func show_textbox():
	textbox_container.show()
	
func add_text(dialogue_text):
	dialogue.text = dialogue_text
	animation.speed_scale = 50 / len(dialogue_text)
	animation.play("text_display")
