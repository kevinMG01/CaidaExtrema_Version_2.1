extends Camera2D


var nivel = 4



func _ready() -> void:
	ejecutar_limite_Camara()


func ejecutar_limite_Camara():
	# Crea el nombre de clave según el nivel
	var clave :String = "nivel_%s" % nivel
	
	# Obtiene el array de límites desde el diccionario
	var tamaño_Actual_Camara = tamaños_limite_Camara(clave) #mejorarlo

	# Asigna los límites de la cámara
	limit_left   = tamaño_Actual_Camara[0]
	limit_top    = tamaño_Actual_Camara[1]
	limit_right  = tamaño_Actual_Camara[2]
	limit_bottom = tamaño_Actual_Camara[3]

# no es eficiente, se podria cambiar y que se ejecute desde el nivel enves de camara seria mas eficiente
	drag_bottom_margin = tamaño_margin("dimencion_borde_top") 


func tamaños_limite_Camara(limite) -> Array:
	# left, top, ringht, bottom
	var dimenciones_Limite_camara: Dictionary = {
		"nivel_1": [0,0,1250,3500],
		"nivel_2": [0,0,1250,6300],
		"nivel_3": [0,0,1250,9670],
		"nivel_4": [0,0,1250,11350],
		"nivel_5": [0,0,1250,14000]
	}
	return dimenciones_Limite_camara[limite]

func tamaño_margin(clave: String) -> float:
	#cambiamos solo el margin "bittom margin"
	var dimenciones = {
		"dimencio_normal": 0.55,
		"dimencion_borde_bottom": 1.0,
		"dimencion_borde_top": 0.0,
	}
	return dimenciones[clave]
