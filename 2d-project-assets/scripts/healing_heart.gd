extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var heart_animation: AnimatedSprite2D = $HeartAnimation

# Si el jugador toca el corazon, lo recoge
func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		AudioController.play_pick_up_item()
		#Cura un 50% de la vida
		body.heal_damage(body.max_health * 0.5)
		#Corazon se destruye
		queue_free()


func _ready() -> void:
	$HeartAnimation.play("default")
	AudioController.play_heart_spawn(global_position)
