extends Node

export (PackedScene) var Zombie
export (PackedScene) var Zombie2

var screen_size
var score

func _ready():
	randomize()
	screen_size = get_viewport().get_visible_rect().size

func _on_EnemyTimer_timeout():
	$ZombiePath/ZombieSpawnLocation.offset = randi()
	var enemy = Zombie.instance()
	add_child(enemy)
	enemy.position = $ZombiePath/ZombieSpawnLocation.position

func _on_ScoreTimer_timeout():
	score += 1
	$UI.update_score(score)

func _on_DifficultTimer_timeout() -> void:
	$EnemyTimer.wait_time -= 0.5
	if $EnemyTimer.wait_time == 0.5:
		$DifficultTimer.stop()

func new_game():
	score = 0
	$EnemyTimer.wait_time = 2
	$Player.show()
	$EnemyTimer.start()
	$ScoreTimer.start()
	$DifficultTimer.start()
	$Enemy2Timer.start()

func game_over():
	$EnemyTimer.stop()
	$Enemy2Timer.stop()
	$ScoreTimer.stop()
	$UI.show_game_over()
	#$UI.show_message(score)
	get_tree().call_group("enemies", "queue_free")


func _on_Enemy2Timer_timeout():
	$ZombiePath/ZombieSpawnLocation.offset = randi()
	var enemy2 = Zombie2.instance()
	add_child(enemy2)
	enemy2.position = $ZombiePath/ZombieSpawnLocation.position
