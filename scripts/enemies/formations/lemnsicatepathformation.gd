extends PathFormation

func _init():
	size = 200

func path_position(angle):
	return Vector2(cos(angle)/(1+(sin(angle)**2)), (cos(angle)*sin(angle))/(1+(sin(angle)**2)))
