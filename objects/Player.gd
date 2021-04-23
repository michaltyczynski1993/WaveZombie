extends KinematicBody2D
signal game_over
signal bullet_out
signal max_bullet_numer

var can_shoot = true

export (PackedScene) var Bullet = preload("res://src/objects/Bullet.tscn")

export (int) var speed = 150
var screen_size
var velocity = Vector2()

func get_input():
	
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if can_shoot == true:
		if Input.is_action_just_pressed("shoot"):
			shoot()
	velocity = velocity.normalized() * speed


func _physics_process(delta):
	look_at(get_global_mouse_position())
	get_input()
	position += velocity * delta
	position.x = clamp(position.x, 20, screen_size.x -20)
	position.y = clamp(position.y, 20, screen_size.y -20)
	velocity = move_and_slide(velocity)

func shoot():
	if self.visible:
		var b = Bullet.instance()
		owner.add_child(b)
		b.transform = $Muzzle.global_transform
		$Shoot.play()
		emit_signal("bullet_out")
	

func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()

func die():
	hide()
	emit_signal("game_over")


func _on_UI_gun_reloading():
	can_shoot = false
	$ReloadingTimer.start()


func _on_ReloadingTimer_timeout():
	can_shoot = true
	emit_signal("max_bullet_numer")
