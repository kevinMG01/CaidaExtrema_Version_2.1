extends CharacterBody2D

var bomba_congenar = preload("res://escenas/enemies/dron/bombas/congelar/congelar.tscn")
var bomba_paralizar

const SPEED = 250.0
var UMBRAL_X = 7.0

var jugador = null

func _physics_process(delta: float) -> void:
	if jugador == null:
		return
	var direccion = (jugador.global_position - global_position).normalized()
	velocity = direccion * SPEED

	move_and_slide()


func _on_detectar_jugador_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		jugador = body


func spawn_bombas():
	var new_bomba = bomba_congenar.instantiate()
	get_tree().current_scene.add_child(new_bomba)

	# centro de la pantalla = jugador
	var center = jugador.global_position
	var screen_size = get_viewport_rect().size

	# bordes del viewport en coordenadas del mundo
	var top_left = center - screen_size / 2
	var top_right = center + Vector2(screen_size.x/2, -screen_size.y/2)

	var x = randf_range(top_left.x, top_right.x)
	var y = top_left.y

	new_bomba.global_position = Vector2(x, y)
