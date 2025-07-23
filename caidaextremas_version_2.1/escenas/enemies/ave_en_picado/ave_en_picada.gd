extends CharacterBody2D

@onready var collision_shape_2derecha = $Attack_derecha/CollisionShape2D
@onready var collision_shape_2izquierda = $Attack_izquierda/CollisionShape2D

var SPEED : int = 300.0
var direccion_actual : String 

func _physics_process(delta):
	move_and_slide()


func _on_daño_body_entered(body):
	if body.is_in_group("player"):
		body.queue_free()


func _on_attack_derecha_body_entered(body):
	if body.is_in_group("player"):
		direccion_actual = "derecha"
		if direccion_actual == "derecha":
			velocity.y = +SPEED
			velocity.x = +SPEED
			collision_shape_2izquierda.visible = false



func _on_attack_izquierda_body_entered(body):
	if body.is_in_group("player"):
		direccion_actual = "izquierda"
		if direccion_actual == "izquierda":
			velocity.y = +SPEED
			velocity.x = -SPEED
			collision_shape_2derecha.visible = false

func _on_attack_izquierda_body_exited(body):
	if body.is_in_group("player"):
		direccion_actual = "izquierda"
		if direccion_actual == "izquierda":
			velocity.y = +SPEED
			velocity.x = -SPEED
			collision_shape_2derecha.visible = false

func _on_attack_derecha_body_exited(body):
	if body.is_in_group("player"):
		direccion_actual = "derecha"
		if direccion_actual == "derecha":
			velocity.y = +SPEED
			velocity.x = +SPEED
			collision_shape_2izquierda.visible = false
