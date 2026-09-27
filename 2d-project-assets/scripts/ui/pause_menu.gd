extends Control

@onready var panel: Panel = $Panel
@onready var settings: Panel = $Settings

#Funciones

func _ready():
	panel.visible = false
	settings.visible = false
	
	settings.back_pressed.connect(back_to_mpause)
	$AnimationPlayer.play("RESET")


func resume():
	print("RESUME SE ESTÁ EJECUTANDO!!")
	#Reanuda el juego, oculta la UI
	get_tree().paused = false
	panel.visible = false
	settings.visible = false
	$AnimationPlayer.play_backwards("blur")


func pause():
	print("PAUSE SE ESTÁ EJECUTANDO!!!")
	#Pausa el juego, abre el menu pausa
	get_tree().paused = true
	settings.visible = false
	panel.visible = true
	$AnimationPlayer.play("blur")


func back_to_mpause():
	#Oculta settings y abre menu pausa
	settings.visible = false
	panel.visible = true
	$AnimationPlayer.play("blur")


func exit():
	get_tree().quit()


#Funciones al presionar Esc
func testEsc():
	if Input.is_action_just_pressed("esc"):
		
			#Si estas en el menu de ajustes, Esc= volver al menu de pausa
			if settings.visible:
				back_to_mpause()

			#Si estas en el menu de pausa, Esc= vuelves al juego
			elif get_tree().paused:
				resume()
			
			#Sino, pausa
			else:
				pause()

#Funciones de los botones
func _on_resume_button_pressed() -> void:
	resume()

func _on_restart_button_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_settings_pressed() -> void:
	panel.visible = false
	settings.visible = true


func _on_exit_button_pressed() -> void:
	exit()


func _process(delta: float) -> void:
	testEsc()
