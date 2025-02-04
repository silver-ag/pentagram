extends Enemy

var tick = true

# Called when the node enters the scene tree for the first time.
func shoot():
	var angle = 0.0 if tick else PI/4
	for i in 4:
		var projectile = projectile_scene.instantiate()
		get_tree().root.add_child(projectile)
		get_tree().root.move_child(projectile,0)
		projectile.position = global_position
		projectile.rotation = -angle
		projectile.angle = angle
		angle += PI/2
	tick = not tick
