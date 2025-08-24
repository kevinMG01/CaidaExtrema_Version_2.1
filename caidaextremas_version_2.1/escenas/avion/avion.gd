extends Sprite2D

var player = preload("res://escenas/player/player.tscn")

var player_en_escena = false

func _physics_process(delta: float) -> void:
	position.x += 2


func spawn():
	var new_player = player.instantiate()
	new_player.global_position = $player.global_position
	$player.visible = false
	$Camera2D.queue_free()
	get_parent().add_child(new_player)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if not player_en_escena:
			spawn()
			player_en_escena = true


func _on_timer_timeout() -> void:
	if not player_en_escena:
		spawn()
		player_en_escena = true
