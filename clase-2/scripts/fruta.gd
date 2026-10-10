extends Area2D

signal recolectada(puntos: int)

@export var puntos: int = 10


func _on_area_entered(area: Area2D) -> void:
	recolectada.emit(puntos)
	queue_free()
