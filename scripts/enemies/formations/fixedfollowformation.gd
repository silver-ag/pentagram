extends Formation

@onready var player = get_tree().root.get_child(0).get_node("character")
var distance = 200
var fixed_offsets = []

func get_fixed_offsets():
	return [Vector2(0,0),
			Vector2(-25,-50),Vector2(25,-50),
			Vector2(-50,-100),Vector2(0,-100),Vector2(50,100),
			Vector2(-75,-150),Vector2(-25,-150),Vector2(25,-150),Vector2(75,-150),
			Vector2(-100,-200),Vector2(-50,-200),Vector2(0,-200),Vector2(50,-200),Vector2(100,-200)]

func initialise_formation():
	fixed_offsets = get_fixed_offsets()

func move_formation(_delta):
	# move down towards the first position, which should be directly in the firing line
	for i in members.size() - 1:
		if members[i] == null:
			members[i] = members[i+1]
			members[i+1] = null

func get_target(index):
	return fixed_offsets[index] + player.position + Vector2(0,-distance)
