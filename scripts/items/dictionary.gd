extends PassiveItem

@onready var orbiter = $orbiter
var player = null
var is_equipped = false
var angle = 0

func _init():
	item_name = "dictionary"
	tooltip = ""
	delusion = 1
	icon = preload("res://images/items/dictionary.png")

func equipped(player_ref):
	orbiter.show()
	is_equipped = true
	player = player_ref

func unequipped():
	orbiter.hide()
	is_equipped = false

func _process(delta):
	if is_equipped:
		angle += delta * player.get_node("inventory").delusion
	orbiter.position = Vector2(100 * sin(angle), 100 * cos(angle))

func _on_orbiter_area_entered(area):
	if area is EnemyProjectile:
		area.get_parent().remove_child(area)
		area.queue_free()
