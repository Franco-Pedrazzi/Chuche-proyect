extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var dialogue = $TextboxContainer/MarginContainer/Dialogue
@onready var animation = $AnimationPlayer

enum State {
	READY,
	READING,
	FINISHED
}
var current_state = State.READY

func _process(delta):
	match current_state:
		State.READY:
			pass
		State.READING:
			pass
		State.FINISHED:
			pass

func _ready():
	print("Starting state: READY")
	hide_textbox()
	
	add_text("Tenemos que acabar\ncon este Chuche!")
	await Input.is_key_pressed(KEY_Z)
	add_text("Juntos...\nsomos Guiso!")
	await Input.is_key_pressed(KEY_Z)
	hide_textbox()

func hide_textbox():
	dialogue.text = ""
	textbox_container.hide()
	
func show_textbox():
	textbox_container.show()
	
func add_text(dialogue_text):
	show_textbox()
	dialogue.text = dialogue_text
	change_state(State.READING)
	animation.speed_scale = 50 / len(dialogue_text)
	animation.play("text_display")

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to READY")
		State.READING:
			print("Changing state to READING")
		State.FINISHED:
			print("Changing state to FINISHED")
