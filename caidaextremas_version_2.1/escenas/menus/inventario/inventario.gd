extends Control


@onready var item_list: ItemList = $VBoxContainer/HBoxContainer/ItemList
const INVENTORY_ITEM_UI = preload("res://escenas/menus/inventario/Items/inventory_item_ui.tscn")
@onready var item_seleccionado: GridContainer = $HBoxContainer/VBoxContainer/Item_seleccionado


var texturas = [
	preload("res://icon.svg"),
	preload("res://assets/sprites/player/AIRE/paracaida_equipada/conparacaidasIdel.png")
]

func _ready():
	randomize()
	var resultado = abrirCaja()
	if resultado != "cajaVacia":
		if resultado == "congelar":
			add_item(resultado, texturas[0], 1)
		elif resultado == "intangible":
			add_item(resultado, texturas[1], 1)
	else:
		print("¡Caja vacía!")


func add_item(type, texture: CompressedTexture2D, quantity: int):
	var node_name = "inventory_item" + str(type)
	if not item_list.has_node(node_name):
		var inventory_item = INVENTORY_ITEM_UI.instantiate()
		inventory_item.name = node_name
		inventory_item.initialize(texture, quantity)
		item_seleccionado.add_child(inventory_item) 
	else:
		var existing_node = item_seleccionado.get_node(node_name)
		existing_node.set_quantity(quantity)


var probabilidades = {
	"cajaVacia": 20,
	"intangible": 40,
	"congelar": 40
}

func pawerUpEnUso(newslot):
	var duplicated_slot = newslot.duplicate()
	item_list.add_child(duplicated_slot)
	duplicated_slot.custom_minimum_size = Vector2(70, 70)

func abrirCaja():
	var valor_aleatorio = randi() % 100 + 1
	var probabilidad_acumulada = 0

	for objeto in probabilidades.keys():
		probabilidad_acumulada += probabilidades[objeto]
		if valor_aleatorio <= probabilidad_acumulada:
			return objeto
			

	return "cajaVacia"
