extends HBoxContainer

var aux=0

func _process(delta):

	var mateo=$".."
	var padre=$"."
	var nroVidas=mateo.lives
	
	if nroVidas!=aux:
		aux=nroVidas
		for i in padre.get_children():
			i.queue_free()
		for i in range(nroVidas):
			var vida = Sprite2D.new()
			vida.texture = preload("res://icon.svg")
			vida.position=Vector2i(100*i,100)
			add_child(vida)

	
