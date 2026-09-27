extends Control

@onready var start_button: Button = $MarginContainer/Main_Buttons/VBoxContainer/Start_Button
@onready var settings_button: Button = $MarginContainer/Main_Buttons/VBoxContainer/Settings_Button
@onready var exit_button: Button = $MarginContainer/Main_Buttons/VBoxContainer/Exit_Button
@onready var settings: Panel = $Settings
@onready var main_buttons: HBoxContainer = $MarginContainer/Main_Buttons



@onready var start_level = preload("res://scenes/survivors_game.tscn") as PackedScene

func _ready():
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	settings_button.button_down.connect(on_settings_pressed)
	settings.back_pressed.connect(on_back_pressed)
	

func on_start_pressed() -> void:
	AudioController.play_music()
	get_tree().change_scene_to_packed(start_level)

func on_exit_pressed() -> void:
	get_tree().quit()
	
func on_settings_pressed() -> void:
	main_buttons.visible = false
	settings.visible = true
	
func on_back_pressed() -> void:
	settings.visible = false
	main_buttons.visible = true
	
