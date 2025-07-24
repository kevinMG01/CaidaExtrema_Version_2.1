extends CharacterBody2D

@onready var colision_derecha = $Colision_Derecha
@onready var colision_izquierda = $Colision_Izquierda
var SPEED : int = 300
var direccion : int = 1

func _ready():
	$AnimatedSprite2D.play()

func _physics_process(delta):
	movimiento_normal()
	move_and_slide()

func movimiento_normal():
	if direccion == 1:
		velocity.x = +SPEED
		if colision_derecha.is_colliding():
			direccion = -1
	elif direccion == -1:
		velocity.x = -SPEED 
		if colision_izquierda.is_colliding():
			direccion = 1

func _on_derecha_body_entered(body):
	if body.is_in_group("player"):
		direccion = 1

func _on_izquierda_body_entered(body):
	if body.is_in_group("player"):
		direccion = -1

func _on_centro_body_entered(body):
	if body.is_in_group("player"):
		SPEED = 0

func _on_centro_body_exited(body):
	SPEED = 300

func _on_daño_body_entered(body):
	if body.is_in_group("player"):
		body.queue_free()
