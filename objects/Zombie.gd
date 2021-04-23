extends KinematicBody2D


var player = null
var move = Vector2.ZERO
var speed = 500
var health = 1

func _physics_process(delta):
	move = Vector2.ZERO
	if player != null:
		look_at(player.position)
		move = position.direction_to(player.position) * speed
	else:
		move = Vector2.ZERO
	move = move.normalized()
	move = move_and_collide(move)
func _ready() -> void:
	pass # Replace with function body.


func _on_PlayerDetector_body_entered(body):
	if body != self:
		if not body.is_in_group("enemies"):
			player = body


func _on_DieDetector_body_entered(body: Node) -> void:
	if not body.is_in_group("enemies"):
		body.die()

func die():
	queue_free()
	
