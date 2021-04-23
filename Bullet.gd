extends Area2D
signal shooted

var speed = 1200

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	body.health -= 1
	queue_free()
	if body.health == 0:
		body.die()
		queue_free()

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
