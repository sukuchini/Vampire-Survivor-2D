extends HSlider

@export var audio_bus_name: String

var audio_bus_id 

func _ready() -> void:
	#Coge el número que tiene el bus que se llama audio_bus_name
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name) 


func _on_value_changed(value: float) -> void:
	#Para arreglar que la bajada de audio no es lineal
	var db = linear_to_db(value) 
	#AudioServer coge el volumen del bus de la id y modifica sus db
	AudioServer.set_bus_volume_db(audio_bus_id, db) 
