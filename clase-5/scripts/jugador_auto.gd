extends CharacterBody2D

@export var velocidad: float = 50.0

# a donde va cuando ya no quedan frutas
@export var posicion_final: Vector2 = Vector2(24, 24)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var ultima_direccion: Vector2 = Vector2.DOWN


func _physics_process(_delta: float) -> void:
	var objetivo: Vector2

	# de todas las frutas del grupo agarra la primera
	var fruta := get_tree().get_first_node_in_group("frutas")

	if fruta != null:
		objetivo = fruta.position
	else:
		objetivo = posicion_final

	var direccion := Vector2.ZERO

	if position.x > objetivo.x + 1:
		direccion.x = -1
	if position.x < objetivo.x - 1:
		direccion.x = 1
	if position.y > objetivo.y + 1:
		direccion.y = -1
	if position.y < objetivo.y - 1:
		direccion.y = 1

	direccion = direccion.normalized()

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
