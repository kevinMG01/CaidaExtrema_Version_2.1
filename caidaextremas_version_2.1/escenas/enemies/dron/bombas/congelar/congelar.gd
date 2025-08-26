extends Area2D

var speed = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y += speed


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("payer"):
		body. damage_bombas("congelar")
		self.queue_free()
