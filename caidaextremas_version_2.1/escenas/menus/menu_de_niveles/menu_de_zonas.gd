extends Control

@onready var zona_1: Control = $Zona_1
@onready var zona_2: Control = $Zona_2
@onready var zona_3: Control = $Zona_3
@onready var zona_4: Control = $Zona_4
@onready var jefes_de_esta_area = $Jefes_de_esta_area


var pantalla_a_agrandar : Control


func mostrar_zona(zona_mostrar: Control):
	
	var zonas = [zona_1, zona_2, zona_3, zona_4, jefes_de_esta_area]
	for zona in zonas:
		zona.visible = false
	pantalla_a_agrandar = zona_mostrar
	pantalla_a_agrandar.scale = Vector2(0.3 , 0.3)
	zona_mostrar.visible = true
	
	$agrandar_pantalla.start()
	

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_global_mouse_position()
		var zonas = [zona_1, zona_2, zona_3, zona_4, jefes_de_esta_area]

		for zona in zonas:
			if zona.visible and not zona.get_global_rect().has_point(mouse_pos):
				zona.visible = false

func _on_zona_1_button_down() -> void:
	mostrar_zona(zona_1)

func _on_zona_2_button_down() -> void:
	mostrar_zona(zona_2)

func _on_zona_3_button_down() -> void:
	mostrar_zona(zona_3)

func _on_zona_4_button_down() -> void:
	mostrar_zona(zona_4)

func _on_zona_5_button_down() -> void:
	mostrar_zona(jefes_de_esta_area)

func _on_agrandar_pantalla_timeout() -> void:
	if pantalla_a_agrandar.scale >= Vector2(1 , 1):
		$agrandar_pantalla.stop()
		return
	pantalla_a_agrandar.scale += Vector2(0.1 ,0.1)
