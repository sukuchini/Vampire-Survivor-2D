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
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

#Funciones de los botones
func _on_resume_button_pressed() -> void:
	resume()


func _on_restart_button_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_settings_pressed() -> void:
	pause()
	panel.visible = false
	settings.visible = true

func _on_back_button_pressed() -> void:
	print("BACK FUNCIONA")
	settings.visible = false
	panel.visible = true


func _on_exit_button_pressed() -> void:
	exit()


func _process(delta: float) -> void:
	testEsc()
