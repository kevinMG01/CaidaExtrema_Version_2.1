extends TextureRect









func initialize(texture_rec, valor):
	texture = texture_rec
	$Label.text = str(valor)

func set_quantity(valor):
	$Label.text = str(valor)
