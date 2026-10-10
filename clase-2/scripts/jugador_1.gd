extends Sprite2D

@export var velocidad: float = 100.0

func _process(delta: float) -> void:
	var direccion := Vector2.ZERO

	if Input.is_action_pressed("mover_derecha"):
		direccion.x += 1
	if Input.is_action_pressed("mover_izquierda"):
		direccion.x -= 1
	if Input.is_action_pressed("mover_abajo"):
		direccion.y += 1
	if Input.is_action_pressed("mov	er_arriba"):
		direccion.y -= 1

	direccion = direccion.normalized()
	
	position += direccion * velocidad * delta
