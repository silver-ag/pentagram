extends Formation
class_name PathFormation

var target_angles = []
var speed = 1
var size = 100
@onready var centre = Vector2(get_viewport().size / 2)

func initialise_formation():
	for i in members.size():
		target_angles.append(2*PI*float(i)/float(members.size()))

func move_formation(delta):
	for i in target_angles.size():
		target_angles[i] += speed * delta
		if target_angles[i] > 2 * PI:
			target_angles[i] -= 2 * PI

func get_target(index):
	return centre + (path_position(target_angles[index]) * size)

func path_position(angle):
	return Vector2(sin(angle), cos(angle))
