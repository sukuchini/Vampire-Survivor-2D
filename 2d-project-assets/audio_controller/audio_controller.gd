extends Node2D

@export var mute: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	if not mute:
		play_main_menu_music()
	
func play_music():
	if not mute:
		$Main_Menu_Music.stop()
		$Music.play()

func play_main_menu_music():
	if not mute:
		$Main_Menu_Music.play()

func play_shot() -> void:
	if not mute:
		$Shot.play()

func play_enemy_death(pos: Vector2) -> void:
	if not mute:
		print("SONIDO DE MUERTE EN: ", pos)
		$EnemyDeath.global_position = pos
		$EnemyDeath.play()
			
func play_game_over() -> void:
	if not mute:
		$Music.stop()
		$GameOver.play()
