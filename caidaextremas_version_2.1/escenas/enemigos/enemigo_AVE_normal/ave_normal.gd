extends CharacterBody2D


const SPEED_X = 300.0
const SPEED_Y = 200.0

var jugador = null
var UMBRAL_X = 15.0
var UMBRAL_SEGUIMIENTO_Y = 5.0 

var modo_persecucion_total = false

func _physics_process(delta: float) -> void:
	if jugador == null:
		return

	var delta_x = jugador.global_position.x - global_position.x
	var delta_y = jugador.global_position.y - global_position.y

	move_X(delta_x)
	move_Y(delta_y)


	if delta_y > UMBRAL_SEGUIMIENTO_Y:#se activa cuando el jugador pasa el eje x del ave 
		modo_persecucion_total = true

#  NORMALIZAR velocidad si se mueve en diagonal
	if velocity.length() > SPEED_Y:
		velocity = velocity.normalized() * SPEED_Y

	move_and_slide()

func move_X(direction):
	if abs(direction) > UMBRAL_X:
		velocity.x = sign(direction) * SPEED_X
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED_X)
		velocity.y = move_toward(velocity.y, 0, SPEED_Y)

func move_Y(direction):
	if modo_persecucion_total:
		if abs(direction) > UMBRAL_X:
			velocity.y = sign(direction) * SPEED_Y
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED_Y)

func _on_area_salida_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		jugador = null

func _on_area_entrada_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		jugador = body
