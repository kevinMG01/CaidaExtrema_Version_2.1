extends Node2D


var nivel_ganado : String = "NO"

# Called when the node enters the scene tree for the first time.
func _ready():



	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_meta_body_entered(body):
	if body.is_in_group("player"):
		if GlobalVar.nivel_desbloqueado == 1:
			GlobalVar.nivel_desbloqueado += 1 
		get_tree().change_scene_to_file("res://escenas/menus/menu_de_niveles/Menu_de_zonas.tscn")
