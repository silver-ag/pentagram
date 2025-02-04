extends Enemy

@onready var player = get_tree().root.get_child(0).get_node("character")


func shoot():
	var angle = PI/2 if player.position.x > position.x else -PI/2
	var projectile = projectile_scene.instantiate()
	get_tree().root.add_child(projectile)
	get_tree().root.move_child(projectile,0)
	projectile.position = global_position
	projectile.rotation = -angle
	projectile.angle = angle
