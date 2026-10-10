extends Area2D

signal recolectada(puntos: int)

@export var puntos: int = 10


func _on_area_entered(area: Area2D) -> void:
	# el reproductor esta en el AudioManager, afuera de la fruta:
	# si estuviera adentro, el queue_free() lo borraria antes de que suene
	$"/root/plataformas/AudioManager/SonidoJuntar".play()
	recolectada.emit(puntos)
	queue_free()
