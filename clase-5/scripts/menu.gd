extends Control


func _on_boton_nivel_1_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/granja.tscn")


func _on_boton_nivel_2_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/granja2.tscn")


func _on_boton_salir_pressed() -> void:
	get_tree().quit()


func _on_slider_volumen_value_changed(valor: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(valor / 100.0))
