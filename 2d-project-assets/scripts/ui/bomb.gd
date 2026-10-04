extends Area2D

@onready var explosion_timer: Timer = $ExplosionTimer
@onready var warning_animation: AnimatedSprite2D = $WarningAnimation
@onready var warning_timer: Timer = $WarningTimer
@onready var explosion_hit_box: Area2D = $ExplosionHitBox
@onready var color_rect: ColorRect = $ExplosionHitBox/ColorRect

#Variable necesaria para gestionar la animacion de la explosion
var explosion_fx: ExplosionFX

#La bomba parpadea 7 segundos y cambia a animacion de explosion inminente
func _on_explosion_timer_timeout() -> void:
	warning_animation.stop()
	warning_animation.play("fast_animation")
	$WarningTimer.start()

func _on_warning_timer_timeout() -> void:
	explode()

#Al explotar quita 15hp a enemigos y 30% al jugador
func explode():
	
	#Termina la animacion de explosion inminente para explotar
	AudioController.play_bomb_explosion(global_position)
	warning_animation.visible = false
	
	#Animacion de explosion se ejecutara donde este la bomba
	explosion_fx = ExplosionFX.spawn(
		get_parent(),
		"fire_blast",
		global_position
	)
	
	#Conectamos la deteccion de la finalizacion de la animacion
	explosion_fx.animation_finished.connect(_on_explosion_finished)
	
	#Cogemos el radio de ExplosionHitBox para escalar el tamaño de la animacion
	var radius = explosion_hit_box.get_node("ExplosionCollision").shape.radius
	
	#Obtenemos la informacion de la animacion usando la info su script
	var effect_info = ExplosionFX.info("fire_blast")
	#Obtenemos ancho y alto de la version de 256 y lo pasamos a un vector2
	var cell_size = Vector2(
		effect_info.cell["256"][0],
		effect_info.cell["256"][1]
	)
	## Radio de la hitbox * 2 para calcular su diametro, lo dividimos por el tamaño
	## tamaño original de la animacion y utilizamos el numero obtenido para 
	## escalar tanto horizontal como verticalmente gracias a Vector2.ONE, que 
	## coge los dos valores para que los escale por igual, ya que son el mismo
	explosion_fx.scale = Vector2.ONE * ((radius * 2.0) / cell_size.x)
	
	#Busca cuerpos a los que dañar
	var bodies = $ExplosionHitBox.get_overlapping_bodies()
	
	#Aplica el daño
	for body in bodies:

		if body.is_in_group("enemy"):
			body.take_damage(15)
		
		elif body.is_in_group("player"):

			body.take_damage(body.max_health * 0.3)

#Cuando se acabe la animacion, la bomba se destruye
func _on_explosion_finished() -> void:
	queue_free()

# Si el jugador toca la bomba, la recoge
func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		AudioController.play_pick_up_item()
		body.obtaining_item("bombs")
		queue_free()


func _ready() -> void:
	warning_animation.play("slow_animation")
	$ExplosionTimer.start()
