extends AutomaticItem

var projectile_scene = preload('res://scenes/projectiles/playerprojectile.tscn')

func _init():
	item_name = "the scream"
	tooltip = "\"In the beginning is the scream. We scream.\n\nWhen we write or when we read, it is easy to forget that the beginning is not the word, but the scream. Faced with the mutilation of human lives by capitalism, a scream of sadness, a scream of horror, a scream of anger, a scream of refusal: NO.\"\n\n - john holloway, 'change the world without taking power'"
	mucus = 0
	god = 0
	cigarettes = 0
	delusion = 0
	shark = 0
	cooldown = 0.5
	icon = preload("res://images/items/scream.jpg")
	is_weapon = true

func activate():
	var projectile = projectile_scene.instantiate()
	get_tree().root.add_child(projectile)
	get_tree().root.move_child(projectile,0) # required so the projectile doesn't display above the gui
	projectile.position = global_position
