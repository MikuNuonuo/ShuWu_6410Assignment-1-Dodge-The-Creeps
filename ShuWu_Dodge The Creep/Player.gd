extends Area2D

signal hit
signal health_change(new_health)

export var speed = 400 # How fast the player will move (pixels/sec). #SW
var screen_size # Size of the game window.
var health = 6#SW
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	health = 6


func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func take_damage(amount): #SW
	health -= amount
	if health < 0:
		health = 0
	emit_signal("health_change", health) #SW
	
func _on_Player_body_entered(_body):
	take_damage(2) #SW
	_Player_dead() #SW
	
# if health = 0, player will dead #SW
func _Player_dead():
	if health == 0:
		hide() # Player disappears after being hit.
		emit_signal("hit")
		# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)

func _on_Player_health_change(new_health): #health #SW
	pass # Replace with function body.
