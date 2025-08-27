extends Node

const SAVE_PATH := "user://savegame.json"

var nivel_desbloqueado = 1

#interfas de inventario
var CAJAS_RECOLECTADAS:int = 0
var ITEM_ELEGIDO: String = ""
var inventario_guardado: Array = []

#--------------------------------------------------
func _ready() -> void:
	load_game()

# Guardar partida
func save_game() -> void:
	var data := {
		"nivel_desbloqueado": nivel_desbloqueado,
		"CAJAS_RECOLECTADAS": CAJAS_RECOLECTADAS,
		"ITEM_ELEGIDO": ITEM_ELEGIDO,
		"inventario_guardado": inventario_guardado
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
		print("Juego guardado")

# Cargar partida
func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No hay partida guardada")
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return
	var text := file.get_as_text()
	file.close()
	var json := JSON.new()
	if json.parse(text) != OK:
		return
	var data: Dictionary = json.data

	# Restaurar variables
	nivel_desbloqueado   = data.get("nivel_desbloqueado", 1)
	CAJAS_RECOLECTADAS   = data.get("CAJAS_RECOLECTADAS", 0)
	ITEM_ELEGIDO         = data.get("ITEM_ELEGIDO", "")
	inventario_guardado  = data.get("inventario_guardado", [])
	print("Juego cargado")
