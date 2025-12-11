extends Sprite2D


@export var menu_dead : CanvasLayer
var player = preload("res://escenas/player/player.tscn")

var player_en_escena = false

@export var camara : int = 1

func _physics_process(delta: float) -> void:
	position.x += 2


func spawn():
	var new_player = player.instantiate()
	new_player.global_position = $player.global_position
	new_player.nivel_camara = camara
	$player.visible = false
	$Camera2D.queue_free()
	menu_dead.muerte = true
	menu_dead.player = new_player
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
