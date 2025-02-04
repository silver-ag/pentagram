extends Area2D
class_name Enemy

@export var speed = 200
@export var health = 3
@export var collision_damage = 2
var velocity = Vector2(0,0)
var target_position = Vector2(0,0)
@export var shoot_cooldown = 1.0
var cooldown_tracker = 0
@export var projectile_scene = preload("res://scenes/projectiles/bluearrow.tscn")
var itembox_scene = preload("res://scenes/itembox.tscn")
@export var drop_chance = {"dirt": 0.2, "common": 0, "rare": 0, "unheard-of": 0, "super-ultra-legendary": 0}

@onready var lootmanager = get_tree().root.get_child(0).get_node("Lootmanager")

func _physics_process(delta):
	move(delta)
	if projectile_scene != null:
		cooldown_tracker += delta
		if cooldown_tracker >= shoot_cooldown:
			shoot()
			cooldown_tracker -= shoot_cooldown

func set_target(pos):
	target_position = pos

func move(delta):
	velocity = (target_position - position).limit_length(speed*delta)
	position += velocity

func shoot():
	var projectile = projectile_scene.instantiate()
	get_tree().root.add_child(projectile)
	get_tree().root.move_child(projectile,0)
	projectile.position = global_position

func hit(damage):
	health -= damage
	if health <= 0:
		destroy()

func destroy():
	var p = randf()
	var cumulative_prob = 0.0
	for rarity in drop_chance:
		cumulative_prob += drop_chance[rarity]
		if p <= cumulative_prob:
			var itembox = itembox_scene.instantiate()
			itembox.set_item(lootmanager.get_drop(rarity))
			get_tree().root.add_child.call_deferred(itembox)
			itembox.position = position
			break
	get_parent().remove_child(self)
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.hit(collision_damage)
