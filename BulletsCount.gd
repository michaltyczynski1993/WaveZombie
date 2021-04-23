extends HBoxContainer
var bullet_number = 15
var heart_full = preload("res://assets/Bullet_for_count.png")

func health_update(bullet_number):
	for i in get_child_count():
		get_child(i).visible = bullet_number > i

func _ready():
	pass
