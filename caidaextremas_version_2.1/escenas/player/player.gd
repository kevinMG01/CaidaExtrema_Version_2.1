extends CharacterBody2D

var SPEED :float = 300.0
var JUMP_VELOCITY : float = -500.0
var gravity : float = 1.807 
var masa : float = 0.75

var state = "idle"
var paracaidas_activado = false

func _ready() -> void:
	set_state("idle")

func _physics_process(delta: float) -> void:
	aplicar_gravedad(delta)
	var direction := Input.get_axis("ui_left", "ui_right")
	move(direction)
	update_state(direction)
	move_and_slide()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY * masa
	elif Input.is_action_just_pressed("ui_up") and not is_on_floor() and not paracaidas_activado:
		set_state("abrir_paracaidas")

func move(direction):
	if direction:
		velocity.x = direction * SPEED / masa
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func aplicar_gravedad(delta):
	if not is_on_floor():
		velocity.y += gravity * masa

func update_state(direction):
	# Evita interrumpir animaciones importantes
	if state in ["abrir_paracaidas", "quitar_paracaidas"]:
		return

	if not is_on_floor():
		if paracaidas_activado:
			if direction != 0:
				set_state("run_paracaidas")
			else:
				set_state("paracaidas_equipada")
		else:
			set_state("jump")
	else:
		paracaidas_activado = false
		if paracaidas_activado:
			set_state("quitar_paracaidas")
		elif direction != 0:
			set_state("run")
		else:
			set_state("idle")

func set_state(new_state):
	if state == new_state:
		return

	state = new_state

	match state:
		"idle":
			paracaidas_activado = false
			$AnimatedSprite2D.play("Idle")
			print(state)
		"run":
			paracaidas_activado = false
			$AnimatedSprite2D.play("Run")
			print(state)
		"jump":
			$AnimatedSprite2D.play("Jump")
			print(state)
		"abrir_paracaidas":
			$AnimatedSprite2D.play("abrir_paracaidas")
			print(state)
		"paracaidas_equipada":
			paracaidas_activado = true
			$AnimatedSprite2D.play("paracaidas_equipada")
			print(state)
		"run_paracaidas":
			$AnimatedSprite2D.play("run_paracaidas")
			print(state)
		"quitar_paracaidas":
			$AnimatedSprite2D.play("quitar_paracaidas")
			print(state)

func _on_animated_sprite_2d_animation_finished() -> void:
	if state == "abrir_paracaidas":
		set_state("paracaidas_equipada")
	elif state == "quitar_paracaidas":
		set_state("idle")
