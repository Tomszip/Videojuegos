extends Node2D

var puntaje: int = 0

@onready var etiqueta_puntaje: Label = $UI/PuntajeLabel


func _ready() -> void:
	for fruta in get_tree().get_nodes_in_group("frutas"):
		fruta.recolectada.connect(_on_fruta_recolectada)
	actualizar_puntaje()


func _on_fruta_recolectada(puntos: int) -> void:
	puntaje += puntos
	actualizar_puntaje()


func actualizar_puntaje() -> void:
	etiqueta_puntaje.text = "Puntos: %d" % puntaje
