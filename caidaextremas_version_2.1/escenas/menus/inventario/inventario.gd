extends Control



const INVENTORY_ITEM_UI = preload("res://escenas/menus/inventario/Items/inventory_item_ui.tscn")
@onready var item_seleccionado: GridContainer = $HBoxContainer/VBoxContainer/Item_seleccionado
@onready var grid_container: GridContainer = $VBoxContainer/HBoxContainer/GridContainer

var texturas = [
	preload("res://icon.svg"),
	preload("res://assets/sprites/player/AIRE/paracaida_equipada/conparacaidasIdel.png")
]

func _ready():
	randomize()
	cargar_inventario()
	print(GlobalVar.inventario_guardado)
	print()

func add_item(type, texture: CompressedTexture2D, quantity: int, sobrescribir := false):
	var node_name = "inventory_item" + str(type)

	if not grid_container.has_node(node_name):
		var inventory_item = INVENTORY_ITEM_UI.instantiate()
		inventory_item.item = type
		inventory_item.inventario = self
		inventory_item.name = node_name
		inventory_item.initialize(texture, quantity)
		grid_container.add_child(inventory_item)
	else:
		var existing_node = grid_container.get_node(node_name)
		if sobrescribir:
			existing_node.set_quantity(quantity)
		else:
			var nueva_cantidad = existing_node.cantidad + quantity
			existing_node.set_quantity(nueva_cantidad)

var probabilidades = {
	"cajaVacia": 20,
	"intangible": 40,
	"congelar": 40
}

func abrirCaja():
	var valor_aleatorio = randi() % 100 + 1
	var probabilidad_acumulada = 0

	for objeto in probabilidades.keys():
		probabilidad_acumulada += probabilidades[objeto]
		if valor_aleatorio <= probabilidad_acumulada:
			return objeto
	return "cajaVacia"

func usar_habilidad(item):
	for child in item_seleccionado.get_children():
		child.queue_free()
	var inventory_item = INVENTORY_ITEM_UI.instantiate()
	match item:
		"congelar":
			inventory_item.initialize(texturas[0], 1)
		"intangible":
			inventory_item.initialize(texturas[1], 1)
		_:
			return
	item_seleccionado.add_child(inventory_item)

func _on_caja_button_down() -> void:
	if GlobalVar.CAJAS_RECOLECTADAS < 1:
		return

	var resultado = abrirCaja()
	match resultado:
		"congelar":
			add_item(resultado, texturas[0], 1)
		"intangible":
			add_item(resultado, texturas[1], 1)
		"cajaVacia":
			print("¡Caja vacía!")
	GlobalVar.CAJAS_RECOLECTADAS -= 1

# GUARDAR INVENTARIO (antes de salir de la escena)
func guardar_inventario():
	GlobalVar.inventario_guardado.clear()

	for item in grid_container.get_children():
		var data = {
			"type": item.item,
			"quantity": item.cantidad,
			"texture_path": item.texture.resource_path
		}
		GlobalVar.inventario_guardado.append(data)

# CARGAR INVENTARIO (cuando entra a la escena)
func cargar_inventario():

	for child in grid_container.get_children():
		child.queue_free()
	# CARGA desde la variable global
	for data in GlobalVar.inventario_guardado:
		var tex = load(data["texture_path"]) as CompressedTexture2D
		add_item(data["type"], tex, data["quantity"],true)



func _on_retroceder_button_down() -> void:
	guardar_inventario()
	print(GlobalVar.inventario_guardado)
	get_tree().change_scene_to_file("res://escenas/menus/menu_principal/menu_principal.tscn")
