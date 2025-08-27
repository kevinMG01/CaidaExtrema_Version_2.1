extends Control

@export var nivel : Node2D
var escena : Array = []

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file(escena)
	pass # Replace with function body.



func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/menus/menu_principal/menu_principal.tscn")
	pass # Replace with function body.
