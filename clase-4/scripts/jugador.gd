extends CharacterBody2D

@export var velocidad: float = 90.0
@export var fuerza_salto: float = -260.0
@export var gravedad: float = 600.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var mirando_derecha: bool = true
var posicion_inicial: Vector2


func _ready() -> void:
	posicion_inicial = position


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravedad * delta

	# solo se puede saltar apoyado en el piso, asi no hay doble salto
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = fuerza_salto

	var direccion := Input.get_axis("mover_izquierda", "mover_derecha")
	velocity.x = direccion * velocidad

	move_and_slide()

	# si se cae por un hueco, vuelve al principio
	if position.y > 300:
		position = posicion_inicial
		velocity = Vector2.ZERO

	actualizar_animacion(direccion)


func actualizar_animacion(direccion: float) -> void:
	if direccion != 0:
		mirando_derecha = direccion > 0

	var lado := "derecha" if mirando_derecha else "izquierda"

	if direccion == 0:
		sprite.play("quieto_" + lado)
	else:
		sprite.play("caminar_" + lado)
