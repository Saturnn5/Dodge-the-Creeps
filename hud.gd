extends CanvasLayer

# Notifies main.gd when the button is pressed
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game over man, game over!")
	# Wait until MessageTimer has counted down
	await $MessageTimer.timeout
	
	# Initialize the message text
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	
	# Wait a second and then show the start button
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_button_down():
	start_button_logic()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_button_logic()

func start_button_logic():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide
