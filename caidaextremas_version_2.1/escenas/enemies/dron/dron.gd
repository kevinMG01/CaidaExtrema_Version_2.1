extends CharacterBody2D

var bomba_congenar = preload("res://escenas/enemies/dron/bombas/congelar/congelar.tscn")
var bomba_paralizar

var SPEED = 210.0
var UMBRAL_X = 7.0

var jugador = null

var bombas_conjelar_max = 2
var bombas_relentizar_max = 4

var posiciones_bombas : Array[Vector2] = []
var distancia_minima := 30

@export var fases : int = 1

#fase 2
var pos_ancla
var pos_dirigida

var tiempo_embestida = 5

enum Estado {
	ESPERANDO,
	EMBESTIDA,
	REGRESO
}
var estado : Estado = Estado.ESPERANDO

 

func _physics_process(delta: float) -> void:
	if jugador == null:
		return

	match estado:
		Estado.EMBESTIDA:
			velocity = (pos_dirigida - pos_ancla).normalized() * SPEED
		Estado.REGRESO:
			velocity = (pos_dirigida - global_position).normalized() * SPEED
		Estado.ESPERANDO:
			velocity = (jugador.global_position - global_position).normalized() * SPEED
	$AnimatedSprite2D.play("default")
	move_and_slide()

func deterninar_fases():
	if fases == 1 :
		$envestida.stop()
	elif fases == 2:
		$bomba_teledirigida.start(10)
		$spwn_enemigos.start(15)
		$envestida.start(tiempo_embestida)

func _on_detectar_jugador_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		jugador = body
		$TimerBombas.start()
		deterninar_fases()

func spawn_bombas(tipoBom):
	var bombas: Dictionary = {
		"congelar" : preload("res://escenas/enemies/dron/bombas/congelar/congelar.tscn"),
		"relentozar" : preload("res://escenas/enemies/dron/bombas/relentizar/relentizar.tscn")
	}
	var escena_bomba = bombas[tipoBom]
	var new_bomba = escena_bomba.instantiate()
	get_tree().current_scene.add_child(new_bomba)

	var center = jugador.global_position
	var screen_size = get_viewport_rect().size

	var top_left = center - screen_size / 2
	var top_right = center + Vector2(screen_size.x/2, -screen_size.y/2)

	var posicion_valida = false
	var intentos = 0

	while not posicion_valida and intentos < 20:
		intentos += 1
		
		var x = randf_range(top_left.x, top_right.x)
		var y = top_left.y
		var nueva_pos: Vector2 = Vector2(x, y)

		posicion_valida = true
		for p in posiciones_bombas:
			if p.distance_to(nueva_pos) < distancia_minima:
				posicion_valida = false
				break

		if posicion_valida:
			posiciones_bombas.append(nueva_pos)

		new_bomba.global_position = nueva_pos
	#$alerta.visible = true
	#$stop_ani_alesta.start(2)

func spawn_bombas_fase_2(enem):
	var enemigos : Dictionary = {
		"ave_normal": preload("res://escenas/enemies/enemigo_AVE_normal/ave_normal.tscn"),
		"ave_en_picada": preload("res://escenas/enemies/ave_en_picado/Ave_en_picada.tscn"),
		"globo": preload("res://escenas/enemies/globo/globo.tscn"),
		"vaca": preload("res://escenas/enemies/cow/Vaca.tscn")
	}
	var enemi = enemigos.keys()
	var enemi_tipo = enemi[randi() % enemi.size()]
	var escena_enemi = enemigos[enemi_tipo]

	var bombas: Dictionary = {
		"congelar" : preload("res://escenas/enemies/dron/bombas/congelar/congelar.tscn"),
		"relentozar" : preload("res://escenas/enemies/dron/bombas/relentizar/relentizar.tscn")
	}
	
	var tipos = bombas.keys()
	var tipo = tipos[randi() % tipos.size()]
	var escena_bomba = bombas[tipo]

	match enem:
		"enemigos":
			var new_enemigo = escena_enemi.instantiate()
			get_parent().add_child(new_enemigo)
			# centro de la pantalla = jugador
			var center = jugador.global_position
			var screen_size = get_viewport_rect().size

			# bordes del viewport en coordenadas del mundo
			var top_left = center - screen_size / 2
			var bottom_right = center + screen_size / 2

			# Elegimos un X aleatorio dentro del ancho visible
			var x = randf_range(top_left.x, bottom_right.x)
			# Usamos el borde inferior (parte baja de la cámara)
			var y = bottom_right.y

			new_enemigo.global_position = Vector2(x, y)

		"bomba":
			var new_enemigo = escena_bomba.instantiate()
			new_enemigo.direction = jugador.global_position - global_position
			get_parent().add_child(new_enemigo)

func _on_timer_bombas_timeout() -> void:
	if jugador != null:
		for i in bombas_conjelar_max:
			spawn_bombas("congelar")
		for i in bombas_relentizar_max:
			spawn_bombas("relentozar")
		posiciones_bombas.clear()

func _on_envestida_timeout() -> void:
	if jugador != null:
		pos_ancla = global_position
		pos_dirigida = jugador.global_position
		SPEED = 600.0
		estado = Estado.EMBESTIDA
		$regresar.start(1.6)

func _process(delta: float) -> void:
	if estado == Estado.REGRESO and global_position.distance_to(pos_dirigida) < 500:
		estado = Estado.ESPERANDO
		SPEED = 210.0
		$envestida.start(tiempo_embestida) 

func _on_regresar_timeout() -> void:
	if jugador != null:
		var center = jugador.global_position
		var screen_size = get_viewport_rect().size
		
		var top_left = center - screen_size / 2
		var top_right = center + Vector2(screen_size.x/2, -screen_size.y/2)
		
		var x = randf_range(top_left.x, top_right.x)
		var y = top_left.y - 50  # un poco más arriba del borde
		
		pos_dirigida = Vector2(x, y)
		SPEED = 400.0
		estado = Estado.REGRESO

func _on_bomba_teledirigida_timeout() -> void:
	if jugador != null:
		spawn_bombas_fase_2("bomba")

func _on_spwn_enemigos_timeout() -> void:
	if jugador != null:
		spawn_bombas_fase_2("enemigos")

func _on_stop_ani_alesta_timeout() -> void:
	$alerta.visible = false
