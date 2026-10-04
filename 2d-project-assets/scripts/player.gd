extends CharacterBody2D

signal health_depleted

#Vida del jugados
var max_health = 100.0
var health = max_health

#Inventario del jugador
var inventory = {
	"bombs" : 0,
	"healing heart" : 0,
}

#Movimiento del jugador
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", 
	"move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	#Animacion al caminar si detecta que se mueve
	if velocity .length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	#Si detecta contacto con un slime, pierde vida
	const DAMAGE_RATE = 10.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			
	#Comprobar si pulsa click derecho
	right_click()
	
#Pierde tanta vida como daño le hayan pasado a la funcion (bomba)
func take_damage(damage):
	health -= damage
	
#Si el player toca un item antes de que se destruya, lo adquiere
func obtaining_item(item):
	inventory[item] += 1
	print(inventory)

func drop_bomb() -> void:
	var player_bomb = preload("res://scenes/player_bomb.tscn").instantiate()
	if inventory["bombs"] > 0:
		get_parent().add_child(player_bomb)
		player_bomb.global_position = global_position
		inventory["bombs"] -= 1
		
func right_click():
	if Input.is_action_just_pressed("right_click"):
		drop_bomb()
		print(inventory)
