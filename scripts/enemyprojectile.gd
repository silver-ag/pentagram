extends Area2D


@export var speed = 750
@export var damage = 1
var angle = 0

func _process(delta):
	position += Vector2(sin(angle),cos(angle)) * speed * delta


func _on_body_entered(body):
	if body is Player:
		body.hit(damage)
		get_parent().remove_child.call_deferred(self)
		queue_free.call_deferred()
