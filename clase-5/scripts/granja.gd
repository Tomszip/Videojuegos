extends Node2D

@export var duracion_partida: float = 60.0

var jugando: bool = true
var frutas_restantes: int = 0

@onready var etiqueta_puntaje: Label = $UI/Control/MarginContainer/HBoxContainer/PuntajeLabel
@onready var etiqueta_maximo: Label = $UI/Control/MarginContainer/HBoxContainer/MaximoLabel
@onready var etiqueta_tiempo: Label = $UI/Control/MarginContainer/HBoxContainer/TiempoLabel
@onready var etiqueta_final: Label = $UI/FinalLabel
@onready var reloj: Timer = $reloj
@onready var jugador: CharacterBody2D = $jugador_2
@onready var jugador_auto: CharacterBody2D = $jugador_auto


func _ready() -> void:
	Global.cargar()

	var frutas := get_tree().get_nodes_in_group("frutas")
	frutas_restantes = frutas.size()
	for fruta in frutas:
		fruta.recolectada.connect(_on_fruta_recolectada)

	etiqueta_final.hide()
	reloj.wait_time = duracion_partida
	reloj.start()
	actualizar_puntaje()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://escenas/menu.tscn")

	if jugando:
		etiqueta_tiempo.text = "Tiempo: %d" % ceil(reloj.time_left)


func _on_fruta_recolectada(puntos: int) -> void:
	if not jugando:
		return
	Global.puntos += puntos
	frutas_restantes -= 1

	if Global.puntos > Global.max_puntos:
		Global.max_puntos = Global.puntos
		Global.grabar()

	actualizar_puntaje()

	if frutas_restantes <= 0:
		terminar_partida("¡Juntaste todas!")


func _on_reloj_timeout() -> void:
	etiqueta_tiempo.text = "Tiempo: 0"
	terminar_partida("¡Se acabó el tiempo!")


func terminar_partida(mensaje: String) -> void:
	jugando = false
	reloj.stop()
	etiqueta_final.text = "%s\nPuntaje final: %d" % [mensaje, Global.puntos]
	etiqueta_final.show()
	jugador.detener()
	jugador_auto.detener()


func actualizar_puntaje() -> void:
	etiqueta_puntaje.text = "Puntos: %d" % Global.puntos
	etiqueta_maximo.text = "Máximo: %d" % Global.max_puntos
