extends TextureRect


var inventario: Control
var item: String = ""
var cantidad: int = 0

func initialize(texture_rec, valor):
	cantidad = valor
	texture = texture_rec
	$Label.text = str(valor)

func set_quantity(valor):
	cantidad = valor
	$Label.text = str(valor)

func _on_button_button_down() -> void:
	inventario.usar_habilidad(item)
	GlobalVar.ITEM_ELEGIDO = item
