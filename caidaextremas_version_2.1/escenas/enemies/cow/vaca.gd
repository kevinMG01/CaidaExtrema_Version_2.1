extends CharacterBody2D

var direccion : int = 1
var velocidad : int = 350
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	position.x += velocidad * direccion * delta
	if position.x > get_viewport_rect().size.x - 60 or position.x < 60:
		direccion *= -1
	
