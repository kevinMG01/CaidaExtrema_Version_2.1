extends Area2D

var speed = 650
var direction: Vector2 = Vector2.DOWN  # Por defecto hacia abajo

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	$AnimatedSprite2D.play("default")

func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body. damage_bombas("congelar")
		self.queue_free()
