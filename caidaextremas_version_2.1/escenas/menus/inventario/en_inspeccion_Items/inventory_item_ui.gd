extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func initialize(texture_rec, valor):
	
	$TextureRect.texture = texture_rec
	$Label.text = str(valor)
	
func set_quantity(valor):
	$Label.text = str(valor)
