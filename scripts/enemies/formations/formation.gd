extends Node
class_name Formation

var members = []

func _ready():
	for child in get_children():
		if child is Enemy:
			members.append(child)
	initialise_formation()

func _process(delta):
	move_formation(delta)
	var surviving = false
	for i in members.size():
		if members[i] != null:
			members[i].set_target(get_target(i))
			surviving = true
	if not surviving:
		get_parent().remove_child(self)
		queue_free()

func initialise_formation():
	pass
func move_formation(_delta):
	pass

func get_target(index):
	var base_position = Vector2((index % 3) * 50, 50 + (int(index / 3) * 50))
	return base_position
