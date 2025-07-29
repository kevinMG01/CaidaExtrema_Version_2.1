extends TextureRect

var item : String = ""
var inventario: Control



func initialize(texture_rec, valor):
	texture = texture_rec
	$Label.text = str(valor)

func set_quantity(valor):
	$Label.text = str(valor)


func _on_button_button_down() -> void:
	inventario.usar_habilidad(item)
