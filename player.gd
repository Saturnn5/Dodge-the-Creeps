extends Area2D

signal hit

@export var speed = 400
var screen_size
var player_size
var temp

func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_size = Vector2($CollisionShape2D.shape.radius, $CollisionShape2D.shape.height / 2)
	#hide()

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	# $ = get_node()
	# $AnimatedSprite2D.play() = get_node(AnimatedSprite2D).play()
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO + player_size, screen_size - player_size)


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
