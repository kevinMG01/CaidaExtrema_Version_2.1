extends Control

@onready var nivel_1 = %Nivel_1
@onready var nivel_2 = %Nivel_2
@onready var nivel_3 = %Nivel_3
@onready var nivel_4 = %Nivel_4
@onready var nivel_5 = %Nivel_5
@onready var nivel_6 = %Nivel_6
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVar.nivel_desbloqueado >= 2:
		nivel_2.disabled = false
	if GlobalVar.nivel_desbloqueado >= 3:
		nivel_3.disabled = false
	if GlobalVar.nivel_desbloqueado >= 4:
		nivel_4.disabled = false
	if GlobalVar.nivel_desbloqueado >= 5:
		nivel_5.disabled = false
	if GlobalVar.nivel_desbloqueado >= 6:
		nivel_6.disabled = false


func _on_nivel_1_pressed():
	get_tree().change_scene_to_file("res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_1/nivel_1.tscn")
	pass # Replace with function body.


func _on_nivel_2_pressed():
	get_tree().change_scene_to_file("res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_2/nivel_2.tscn")
	pass # Replace with function body.


func _on_nivel_3_pressed():
	get_tree().change_scene_to_file("res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_3/nivel_3.tscn")


func _on_nivel_4_pressed():
	get_tree().change_scene_to_file("res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_4/nivel_4.tscn")


func _on_nivel_5_pressed():
	get_tree().change_scene_to_file("res://escenas/menus/menu_de_niveles/zona_1_globos/nivel_5/nivel_5.tscn")
