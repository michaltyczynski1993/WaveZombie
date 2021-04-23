extends CanvasLayer
signal start_game
signal gun_reloading

var instructions = false

func _ready() -> void:
	$ControlInstruction.hide()
	$ScoreLabel.hide()
	$BulletsCount.hide()
	
func update_score(score):
	$ScoreLabel.text = "Alive Time: " + str(score)
	$ScoreInformation.text = "You survived " +str(score) + " seconds"


func show_game_over():
	$PlayButton.show()
	$ScoreInformation.show()
	$Title.show()
	$Controls.show()
	$BackgroundMusic.play()
	$GameBgMusic.stop()
	$ScoreLabel.hide()
	$BulletsCount.hide()

func _on_PlayButton_pressed() -> void:
	$ScoreInformation.hide()
	$PlayButton.hide()
	$Title.hide()
	$Controls.hide()
	$BackgroundMusic.stop()
	$GameBgMusic.play()
	$ScoreLabel.show()
	$BulletsCount.show()
	$BulletsCount.bullet_number = 15
	$BulletsCount.health_update($BulletsCount.bullet_number)
	emit_signal("start_game")


func _on_Controls_pressed():
	if instructions == false:
		instructions = true
	else:
		instructions = false
		
	if instructions == true:
		$ScoreLabel.hide()
		$PlayButton.hide()
		$ScoreInformation.hide()
		$Title.hide()
		$ControlInstruction.show()
		$Controls.text = "Back"
		
	if instructions == false:
		$Controls.text = "Controls"
		$PlayButton.show()
		$ScoreInformation.show()
		$ScoreLabel.show()
		$Title.show()
		$ControlInstruction.hide()


func _on_Player_bullet_out():
	
	$BulletsCount.bullet_number -= 1
	if $BulletsCount.bullet_number < 0:
		$BulletsCount.bullet_number = 0
	if $BulletsCount.bullet_number == 0:
		#start reloading
		emit_signal("gun_reloading")
	$BulletsCount.health_update($BulletsCount.bullet_number)

func _on_Player_max_bullet_numer():
	$BulletsCount.bullet_number = 15
	$BulletsCount.health_update($BulletsCount.bullet_number)
