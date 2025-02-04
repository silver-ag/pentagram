extends Formation

var topleft = Vector2(0,0)
var width = 0
var speed = 150
var formationposition = Vector2(0,0)
var targets = [Vector2(0,200),Vector2(400,200)]
var fixed_offsets = []
var target = 0

func get_fixed_offsets():
	return [Vector2(0,0),
			Vector2(-25,-50),Vector2(25,-50),
			Vector2(-50,-100),Vector2(0,-100),Vector2(50,-100),
			Vector2(-75,-150),Vector2(-25,-150),Vector2(25,-150),Vector2(75,-150),
			Vector2(-100,-200),Vector2(-50,-200),Vector2(0,-200),Vector2(50,-200),Vector2(100,-200)]

func initialise_formation():
	fixed_offsets = get_fixed_offsets()
	topleft = fixed_offsets[0]
	var farright = fixed_offsets[0][0]
	for offset in fixed_offsets:
		if offset.x < topleft.x:
			topleft.x = offset.x
		if offset.y < topleft.y:
			topleft.y = offset.y
		if offset.x > farright:
			farright = offset.x
	width = farright - topleft.x
	formationposition = Vector2(0,0) - topleft
	
	targets = [formationposition,
			   Vector2(formationposition.x + (get_viewport().size.x - width), formationposition.y)]

func move_formation(delta):
	formationposition = formationposition.move_toward(targets[target], speed*delta)
	if formationposition == targets[target]:
		target = (target + 1) % 2

func get_target(index):
	return fixed_offsets[index] + formationposition
