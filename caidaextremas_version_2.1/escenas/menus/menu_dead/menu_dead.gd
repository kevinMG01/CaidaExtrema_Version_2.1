extends CanvasLayer

@export var nivel : int
var escena : Array = [
	"",
	"res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_1/nivel_1.tscn",
	"res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_2/nivel_2.tscn",
	"res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_3/nivel_3.tscn",
	"res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_4/nivel_4.tscn",
	"res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_5/nivel_5.tscn",
]





func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file(escena[nivel])


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/menus/menu_principal/menu_principal.tscn")
