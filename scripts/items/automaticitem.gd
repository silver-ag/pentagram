extends Item
class_name AutomaticItem

var cooldown = 1
var timer = 0

func cooldown_by(delta):
	timer += delta
	if timer > cooldown:
		timer -= cooldown
		activate()
		
func activate():
	print(1)
