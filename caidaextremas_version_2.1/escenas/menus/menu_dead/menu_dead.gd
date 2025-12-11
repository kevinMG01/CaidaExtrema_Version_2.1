extends CanvasLayer
var muerte : bool = false
var player = null

@export var nivel : int = 1
var escena : Array = [
	"",
	"res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_1/nivel_1.tscn",
	"res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_2/nivel_2.tscn",
	"res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_3/nivel_3.tscn",
	"res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_4/nivel_4.tscn",
	"res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_5/nivel_5.tscn",
	"res://escenas/menus/menu_de_niveles/zona_2_ave_persecutora/nivel_6.tscn",
	"res://escenas/menus/menu_de_niveles/zona_2_ave_persecutora/nivel_7.tscn",
	"res://escenas/menus/menu_de_niveles/zona_2_ave_persecutora/nivel_8.tscn",
	"res://escenas/menus/menu_de_niveles/zona_2_ave_persecutora/nivel_9.tscn",
	"res://escenas/menus/menu_de_niveles/zona_2_ave_persecutora/nivel_10.tscn",
	"res://escenas/menus/menu_de_niveles/zona_3_ave_en_picada/nivel_11.tscn",
	"res://escenas/menus/menu_de_niveles/zona_3_ave_en_picada/nivel_12.tscn",
	"res://escenas/menus/menu_de_niveles/zona_3_ave_en_picada/nivel_13.tscn",
	"res://escenas/menus/menu_de_niveles/zona_3_ave_en_picada/nivel_14.tscn",
	"res://escenas/menus/menu_de_niveles/zona_3_ave_en_picada/nivel_15.tscn"
]


func _process(delta: float) -> void:
	if muerte and player == null:
		self.visible = true



func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file(escena[nivel])


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/menus/menu_principal/menu_principal.tscn")
