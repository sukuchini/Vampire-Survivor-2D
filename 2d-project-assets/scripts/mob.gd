extends CharacterBody2D

#Señal para avisar de que el slime a muerto y actualizar asi la puntuacion
signal killed

var health = 3

@onready var player = get_node("/root/Game/Player")

#Animacion caminar del mob se inicia nada mas spawnea
func _ready():
	%Slime.play_walk()

#Movimiento del slime
func _physics_process(delta):	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()
	
#Pierde tanta vida como daño le hayan pasado a la funcion 
func take_damage(damage):
	health -= damage
	%Slime.play_hurt()
	
	#Si pierde toda la vida, el slime muere
	if health <= 0:
		AudioController.play_enemy_death(global_position)
		
		#Avisamos al Game de que el slime ha muerto
		killed.emit()
		queue_free()
		
		#Se ejecuta animacion de muerte en el lugar donde el slime muriera
		const SMOKE_SCENE = preload("res://effects/smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
