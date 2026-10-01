extends Area2D

@onready var explosion_timer: Timer = $ExplosionTimer
@onready var warning_animation: AnimatedSprite2D = $WarningAnimation
@onready var warning_timer: Timer = $WarningTimer

#La bomba parpadea 7 segundos y cambia a animacion de explosion inminente
func _on_explosion_timer_timeout() -> void:
	warning_animation.stop()
	warning_animation.play("fast_animation")
	$WarningTimer.start()

func _on_warning_timer_timeout() -> void:
	explode()

#Al explotar quita 15hp a enemigos y 30% al jugador
func explode():
	
	#busca cuerpos a los que dañar
	var bodies = get_overlapping_bodies()
	#Aqui ira la animacion
	warning_animation.stop()

	
	#aplica el daño
	for body in bodies:
		if body.is_in_group("enemy"):
			body.take_damage(15)
		
		elif body.is_in_group("player"):
			body.take_damage(body.max_health * 0.3)
	#Desactivar el CollisionShape2D para que no siga haciendo daño
	#La animacion tiene que terminar antes del queue_free
	
	queue_free()
	
func _ready() -> void:
	warning_animation.play("slow_animation")
	$ExplosionTimer.start()
