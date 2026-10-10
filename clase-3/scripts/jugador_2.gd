extends CharacterBody2D

@export var velocidad: float = 80.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var ultima_direccion: Vector2 = Vector2.DOWN


func _physics_process(_delta: float) -> void:
	var direccion := Input.get_vector(
		"mover_izquierda", "mover_derecha",
		"mover_arriba", "mover_abajo"
	)

	velocity = direccion * velocidad
	move_and_slide()

	actualizar_animacion(direccion)


func actualizar_animacion(direccion: Vector2) -> void:
	if direccion == Vector2.ZERO:
		sprite.play("quieto_" + nombre_direccion(ultima_direccion))
		return

	ultima_direccion = direccion
	sprite.play("caminar_" + nombre_direccion(direccion))


func nombre_direccion(direccion: Vector2) -> String:
	if abs(direccion.x) > abs(direccion.y):
		return "derecha" if direccion.x > 0 else "izquierda"
	return "abajo" if direccion.y > 0 else "arriba"	
	
func detener() -> void:
	set_physics_process(false)
	velocity = Vector2.ZERO
	sprite.play("quieto_" + nombre_direccion(ultima_direccion))
