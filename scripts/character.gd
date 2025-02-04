extends CharacterBody2D
class_name Player

var speed = 1500
var health = 100
@onready var inventory = $inventory
@onready var healthbar = $healthbar

func _ready():
	healthbar.max_value = health

func _physics_process(delta):
	update_cooldowns(delta)
	var target_position = get_global_mouse_position()
	velocity = (target_position - position).limit_length(speed*delta) / delta
	move_and_slide()
	healthbar.value = health

func update_cooldowns(delta):
	for item in inventory.get_items():
		if item is AutomaticItem:
			item.cooldown_by(delta)

func hit(damage):
	health -= damage
	if health <= 0:
		print("game over")
