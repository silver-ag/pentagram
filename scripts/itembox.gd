extends Area2D

var item = null
var speed = 50
var direction = 0
@onready var texture = $TextureRect

func _physics_process(delta):
	direction += randf_range(-0.2,0.2)
	if direction < 0:
		direction += 2*PI
	elif direction > 2*PI:
		direction -= 2*PI
	position += Vector2(sin(direction), cos(direction)) * delta * speed
	position = position.clamp(Vector2(0,0), get_viewport().size - Vector2i(50,50))

func set_item(itm):
	item = itm
	$TextureRect.texture = item.icon

func _on_body_entered(body):
	if body is Player:
		body.get_node("inventory").add_carried(item)
		get_parent().remove_child.call_deferred(self)
		queue_free()
