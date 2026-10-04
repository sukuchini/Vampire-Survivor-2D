extends HBoxContainer

@onready var option_button: OptionButton = $OptionButton

#Array con los modos de ventana
const WINDOW_MODE_ARRAY : Array[String] = [
	"Full-Screen",
	"Window Mode",
	"Borderless Window",
	"Borderless Full-screen"
]

#Inicializa los valores del array
func _ready():
	add_window_mode_items()
	#Cuando se seleccione algo de la checklist, enviara la señal
	option_button.item_selected.connect(on_window_mode_selected)

#Coge los textos guardados en el array y los mete en OptionButton
func add_window_mode_items() -> void:
	for window_mode in WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode)

#Usamos DisplayServer para cambiar los modos de ventana 
func on_window_mode_selected(index : int) -> void:
	#Usamos match en vez de if para que sea mas eficiente y limpio
	match index:
		0: #Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: #Window mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #Borderless Window
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: #Borderless Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
