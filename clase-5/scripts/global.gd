extends Node

var puntos: int = 0
var max_puntos: int = 0
var nombre_archivo: String = "user://guardado.dat"


func grabar() -> void:
	var archivo := FileAccess.open(nombre_archivo, FileAccess.WRITE)
	archivo.store_var(max_puntos)
	archivo.close()


func cargar() -> void:
	if FileAccess.file_exists(nombre_archivo):
		var archivo := FileAccess.open(nombre_archivo, FileAccess.READ)
		max_puntos = archivo.get_var()
		archivo.close()
