extends CharacterBody2D
 
var SPEED :float = 500.0         
var JUMP_VELOCITY : float = -400.0

var state: String

var paracaidas_activado = true # se ejecuta cuando esta en el estado_aire y determina si tiene el paracaidas o se la quito

const GRAVEDAD_NORMAL : float = 700.0
const GRAVEDAD_PARACAIDAS : float = 300.0

func _ready() -> void:
	set_state("quitar_paracaidas")


func _physics_process(delta: float) -> void:
	aplicar_gravedad(delta)
	var direction := Input.get_axis("ui_left", "ui_right")
	move(direction)
	update_state(direction)
	move_and_slide()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("ui_up") and not is_on_floor():
		if paracaidas_activado:
			set_state("quitar_paracaidas")
		else:
			set_state("abrir_paracaidas")


func move(direction):
	if direction:
		velocity.x = direction * SPEED 
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func aplicar_gravedad(delta):
	if not is_on_floor():
		if paracaidas_activado:
			velocity.y += GRAVEDAD_PARACAIDAS * delta
			velocity.y = min(velocity.y, 300) # limita velocidad máxima de caída con paracaídas
		else:
			velocity.y += GRAVEDAD_NORMAL * delta

func update_state(direction):
	if state in ["abrir_paracaidas"]:
		return

	# Definir grupos de estados
	var estados_suelo := ["idle", "run", "jump",]
	var estados_paracaidas := ["paracaidas_equipada", "quitar_paracaidas"]

# determina cual es el modo acutual, si esta en el suelo o en el aire y ejecuta solo un estado
	if state in estados_suelo:
		if velocity.y < 0:#salto
			set_state("jump")

		elif velocity.y > 0:#baja
			set_state("fall")
		elif direction == 0:
			set_state("idle")
		else:
			set_state("run")
	elif state in estados_paracaidas:
		if paracaidas_activado:
			set_state("paracaidas_equipada")
		else:
			set_state("quitar_paracaidas")

	if is_on_floor() and state not in ["run", "jump"]:
		set_state("idle")

func set_state(new_state):
	if state == new_state: # no permite un estado repetido.
		return

	state = new_state

	match state:
		"idle":
			paracaidas_activado = false
			$AnimatedSprite2D.play("Idle")
			print(state)
		"run":
			$AnimatedSprite2D.play("Run")
			print(state)
		"jump":
			$AnimatedSprite2D.play("Jump")
			print(state)
		"fall":
			$AnimatedSprite2D.play("Fall")
			print(state)
		"abrir_paracaidas":
			$AnimatedSprite2D.play("abrir_paracaidas")
			print(state)
		"paracaidas_equipada":
			paracaidas_activado = true
			$AnimatedSprite2D.play("paracaidas_equipada")
			print(state)
		"quitar_paracaidas":
			paracaidas_activado = false
			$AnimatedSprite2D.play("quitar_paracaidas")
			print(state)

func _on_animated_sprite_2d_animation_finished() -> void:
	if state == "abrir_paracaidas":
		set_state("paracaidas_equipada")
