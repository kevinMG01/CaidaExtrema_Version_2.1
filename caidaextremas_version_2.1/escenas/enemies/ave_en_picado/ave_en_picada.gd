extends CharacterBody2D

@onready var attack_derecha = $Attack_derecha
@onready var attack_izquierda = $Attack_izquierda

var SPEED : int = 400
var direccion_actual : String 

func _physics_process(delta):
	move_and_slide()

func _on_daño_body_entered(body):
	if body.is_in_group("player"):
		body.queue_free()

func _on_attack_derecha_body_entered(body):
	if body.is_in_group("player"):
		direccion_actual = "derecha"
		$Coldawn_attack.start(1)

func _on_attack_izquierda_body_entered(body):
	if body.is_in_group("player"):
		direccion_actual = "izquierda"
		$Coldawn_attack.start(1)

func _on_coldawn_attack_timeout():
	if direccion_actual == "izquierda":
		movimiento_izquierda()
	elif direccion_actual == "derecha":
		movimiento_derecha()
	$Coldawn_attack.stop()
	
func movimiento_izquierda():
	velocity.y = +SPEED
	velocity.x = -SPEED
	attack_derecha.queue_free()

func movimiento_derecha():
	velocity.y = +SPEED
	velocity.x = +SPEED
	attack_izquierda.queue_free()
