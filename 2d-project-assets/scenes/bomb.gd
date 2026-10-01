extends Area2D

func explode():
	var bodies = get_overlapping_bodies()

	for body in bodies:
		if body.is_in_group("enemy"):
			body.take_damage(15)
		
		elif body.is_in_group("player"):
			body.take_damage(body.max_health * 0.3)
	
	queue_free()
