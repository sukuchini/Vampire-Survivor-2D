extends Control

@onready var panel: Panel = $Panel
@onready var settings: Panel = $Settings

#Funciones

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")


func exit():
	get_tree().quit()

#Testear si Esc funciona y abre el menu
func testEsc():
	if Input.is_action_just_pressed("esc"):
	
		print("ESC PULSADO")
		print("PAUSADO ", get_tree().paused)
		print("SETTINGS: ", settings.visible)
		
		if get_tree().paused == false:
			print("-> LLAMANDO A PAUSE")
			pause()
	
		elif settings.visible == true:
			print("-> CERRANDO SETTINGS")
			settings.visible = false
			panel.visible = true

		else:
			print("-> LLAMANDO RESUME")
			resume()

#Funciones de los botones
func _on_resume_button_pressed() -> void:
	resume()


func _on_restart_button_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_settings_pressed() -> void:
	panel.visible = false
	settings.visible = true
	print("PAUSADO: ", get_tree().paused)

func _on_back_button_pressed() -> void:
	settings.visible = false
	panel.visible = true
	$AnimationPlayer.play("blur")


func _on_exit_button_pressed() -> void:
	exit()


func _process(delta: float) -> void:
	testEsc()
