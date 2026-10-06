extends Node2D

#Cargo la bomba
const BOMB_SCENE = preload("res://scenes/bomb.tscn")
const HEART_SCENE = preload("res://scenes/healing_heart.tscn")
#Defino el area de spawn de los items
const ITEM_SPAWN_AREA = Rect2(100, 100, 1720, 880)

#Variables
var score = 0

@onready var mob_timer: Timer = $MobTimer
@onready var bomb_timer: Timer = $BombTimer
@onready var inventory_ui: CanvasLayer = $InventoryUI
@onready var heart_timer: Timer = $HeartTimer


func on_enemy_killed():
	score += 1
	$InventoryUI.set_score(score)

#Mob carga y spawnea en un lugar aleatorio del path
func spawn_mob():
	var new_mob = preload("res://scenes/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	
	#Conectamos la muerte del slime con la puntuacion
	new_mob.killed.connect(on_enemy_killed)
	add_child(new_mob)

#Spawnea una bomba llamando a la funcion spawn_item
func spawn_bomb():
	spawn_item(BOMB_SCENE)

func spawn_heart():
	spawn_item(HEART_SCENE)

#Cuando muera el player sale el Game Over
func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	AudioController.play_game_over()
	get_tree().paused = true

#Creamos una funcion para spawnear items
func spawn_item(item_scene: PackedScene):
	var new_item = item_scene.instantiate()
	new_item.global_position = Vector2(
		#Items spawnearan aleatoriamente en la x e y del area seleccionada
		randf_range(
			ITEM_SPAWN_AREA.position.x,
			ITEM_SPAWN_AREA.end.x
		),
		randf_range(
			ITEM_SPAWN_AREA.position.y,
			ITEM_SPAWN_AREA.end.y
		)
	)
	add_child(new_item)

#Cuando se acabe los timers, spawneas los elementos
func _on_mob_timer_timeout() -> void:
	spawn_mob()

func _on_bomb_timer_timeout() -> void:
	spawn_bomb()

func _on_heart_timer_timeout() -> void:
	spawn_heart()

func _ready() -> void:
	#Creamos los timers para los mobs y items
	$MobTimer.wait_time = randf_range(0.2, 0.6)
	$MobTimer.start()
	$BombTimer.wait_time= randf_range(1.0, 2.0)
	$BombTimer.start()
	$HeartTimer.wait_time = randf_range(90.0, 150.0)
	$HeartTimer.start()
	
	
