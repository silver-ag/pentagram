extends Area2D


@export var velocity = Vector2(0,-750)
@export var damage = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta


func _on_area_entered(area) -> void:
	if area is Enemy:
		area.hit(damage)
		queue_free.call_deferred()
