extends HBoxContainer

@onready var option_button: OptionButton = $OptionButton

#Usamos un diccionario para no usar dos arrays para manejar las res
const RESOLUTION_DICTIONARY: Dictionary = {
	#Usamos Vector2i para que sean int y no float
	"1920 x 1080" : Vector2i(1920, 1080),
	"1280 x 720" : Vector2i(1280, 720),
	"1152 x 648" : Vector2i(1152, 658)
}

func _ready():
	option_button.item_selected.connect(on_resolution_selected)
	add_resolution_items()

#Busca items en el diccionario y los muestra en el check button
func add_resolution_items() -> void:
	for resolution_size_text in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size_text)

func on_resolution_selected(index : int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
