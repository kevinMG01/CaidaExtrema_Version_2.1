extends CharacterBody2D

var state: String

var GRAVEDAD_NORMAL : float = 700.0
var GRAVEDAD_PARACAIDAS : float = 300.0

@export var habilidad_activa: String = "dash" # dash, super_salto,etc.

var  is_dashing :bool = false
var  is_super_salto :bool = false

var atributos: Dictionary = {}
var atributos_extras: Dictionary = {} # no esta programado, es para el futuro


var nivel_camara = 1

func _ready() -> void:
	for key in atributos_Base().keys():
		atributos[key] = atributos_Base(key)
		print(key)

	#atributos["speed"] = 0

	print(atributos)
	atributos["speed"] = atributos_Base("speed")#para reemplasar un atributo
	set_state("quitar_paracaidas")
	print(atributos)

func _physics_process(delta: float) -> void:
	aplicar_gravedad(delta)
	var direction :int = Input.get_axis("ui_left", "ui_right")
	move(direction)
	update_state(direction)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = atributos["jump"]
		print(atributos)
	elif Input.is_action_just_pressed("ui_up") and not is_on_floor():
		if atributos["paracaidas_activado"]:
			set_state("quitar_paracaidas")
		else:
			set_state("abrir_paracaidas")
	if Input.is_action_just_pressed("ui_down"):
		ejecutar_habilidad(habilidad_activa)

func move(direction): # controlamos el movimineto
	if direction:
		velocity.x = direction * atributos["speed"]
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, atributos["speed"])

func aplicar_gravedad(delta):# aplicamos gravedad
	if not is_on_floor():
		if atributos["paracaidas_activado"]:
			velocity.y += GRAVEDAD_PARACAIDAS * delta
			velocity.y = min(velocity.y, atributos["estado_aire_MAX_VEL_CAIDA"]) # limita velocidad máxima de caída con paracaídas
		else:
			velocity.y += GRAVEDAD_NORMAL * delta

func update_state(direction): # controla las animaciones 
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
		if atributos["paracaidas_activado"]:
			set_state("paracaidas_equipada")
		else:
			set_state("quitar_paracaidas")

	if is_on_floor() and state not in ["run", "jump"]:
		set_state("idle")

func set_state(new_state): #ejecuta las animaciones
	if state == new_state: # no permite un estado repetido.
		return

	state = new_state

	collisionshape()

	match state:
		"idle":
			atributos["paracaidas_activado"] = true
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
			atributos["paracaidas_activado"] = true
			$AnimatedSprite2D.play("paracaidas_equipada")
			print(state)
		"quitar_paracaidas":
			atributos["paracaidas_activado"] = false
			$AnimatedSprite2D.play("quitar_paracaidas")
			print(state)

func _on_animated_sprite_2d_animation_finished() -> void:
	if state == "abrir_paracaidas":
		set_state("paracaidas_equipada")

func collisionshape():# controla que colisionshape2d deveria de estar activo y oculta la otras
 #Oculta todos los collision shapes
	var collision_nodes = [$CollisionShape2D, $fall, $sin_paracaidas]
	for node in collision_nodes:
		node.visible = false

	# Muestra solo el que corresponde
	match state:
		"idle", "run", "paracaidas_equipada":
			$CollisionShape2D.visible = true
		"fall", "jump":
			$fall.visible = true
		"quitar_paracaidas":
			$sin_paracaidas.visible = true

func ejecutar_habilidad(nombre: String):
	if is_dashing and nombre == "dash":
		return
	if is_super_salto and nombre == "super_salto":
		return

	match nombre:
		"dash":
			is_dashing = true
			atributos["speed"] = 2000.0
			crear_timer(0.08, func():
				atributos["speed"] = atributos_Base("speed")
				is_dashing = false
			)

		"super_salto":
			is_super_salto = true
			atributos["jump"] = -900.0
			crear_timer(4.0, func():
				atributos["jump"] = atributos_Base("jump")
				is_super_salto = false
				
			)

func crear_timer(tiempo: float, callback: Callable):
	var timer :Timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = tiempo
	add_child(timer)
	timer.connect("timeout", callback)
	
	timer.connect("timeout", func():
		callback.call()
		timer.queue_free()
	)
	
	timer.start()

func atributos_Base(key :String= "") -> Variant:
	var base: Dictionary = {
		"speed": 300.0,
		"jump": -400.0,
		"paracaidas_activado": true,## se ejecuta cuando esta en el estado_aire y determina si tiene el paracaidas o se la quito
		
		"estado_aire_MAX_VEL_CAIDA": 150,
		
	}
	if key != "":
		return base.get(key, null)
	return base



func damage_bombas(new_bomba):
	match new_bomba:
		"relentizar":
			atributos["speed"] = 200 
			GRAVEDAD_NORMAL = 350.0
			GRAVEDAD_PARACAIDAS = 150.0
			crear_timer(3, func():
				atributos["speed"] = atributos_Base("speed")
				GRAVEDAD_NORMAL = 700.0
				GRAVEDAD_PARACAIDAS = 300.0
				)
		"relentizar":
			atributos["speed"] = 0
			GRAVEDAD_NORMAL = 0
			GRAVEDAD_PARACAIDAS = 0
			crear_timer(3, func():
				atributos["speed"] = atributos_Base("speed")
				GRAVEDAD_NORMAL = 700.0
				GRAVEDAD_PARACAIDAS = 300.0
				)
