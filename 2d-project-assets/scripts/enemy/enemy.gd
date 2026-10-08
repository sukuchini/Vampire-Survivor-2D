extends CharacterBody2D
class_name Enemy

@export var stats : EnemyStats

#Señal para avisar de que el slime a muerto y actualizar asi la puntuacion
signal killed


@onready var player = get_node("/root/Game/Player")

#Animacion caminar del mob se inicia nada mas spawnea
func _ready():
	#Iniciar la animacion de caminar
	#%Slime.play_walk()
	pass

#Movimiento del enemigo
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * stats.speed
	move_and_slide()
	
#Pierde tanta vida como daño le hayan pasado a la funcion 
func take_damage(damage):
	stats.health -= damage
	%Slime.play_hurt()
	
	#Si pierde toda la vida, el slime muere
	if stats.health <= 0:
		AudioController.play_enemy_death(global_position)
		
		#Avisamos al Game de que el slime ha muerto
		killed.emit()
		queue_free()
		
		#Se ejecuta animacion de muerte en el lugar donde el slime muriera
		const SMOKE_SCENE = preload("res://effects/smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
