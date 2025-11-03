extends Node

@export var mob_scene: PackedScene

var score
var mobs

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$Player.hide()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	for mob in get_tree().get_nodes_in_group("mobs"):
		mob.queue_free()
	# Waits for the frame to end so that mobs are properly deleted.
	# Not quite sure why this is necessary... Isn't added in tutorial.
	await get_tree().process_frame
	
	# HUD stuff
	$HUD.update_score(score)
	$HUD/ScoreLabel.show()
	$HUD.show_message("Creeps incoming!")
	
	$Music.play()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	# generates a random position along the mob path
	var mob_spawn_loc = $MobPath/MobSpawnLocation
	mob_spawn_loc.progress_ratio = randf()
	# sets the mob's position to the random position
	mob.position = mob_spawn_loc.position
	
	# sets the mob's direction perpendicular to the path direction
	var direction = mob_spawn_loc.rotation + PI / 2
	# add randomness and assigns it to the mob's rotation
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	
	# generates a random velocity from 150 to 250
	# and assigns the value to the mob's velocity
	var velocity = Vector2(randf_range(150, 250), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# spawn the mob by adding it to the scene
	add_child(mob)

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
	$HUD/Message.hide()
