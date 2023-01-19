extends RigidBody2D
var spriteType = randi() % 3 #SW
func _ready():
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	#spriteType = randi() % mob_types.size()
	$AnimatedSprite.animation = mob_types[spriteType]
	_modSize()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	
func _modSize(): #SW
	if spriteType == 0:
		$AnimatedSprite.scale = Vector2(0.5,0.5) 
		$CollisionShape2D.scale = Vector2(0.5,0.5) 
		$VisibilityNotifier2D.scale = Vector2(0.5,0.5) 
	elif spriteType == 1:
		$AnimatedSprite.scale = Vector2(1,1) 
		$CollisionShape2D.scale = Vector2(1,1) 
		$VisibilityNotifier2D.scale = Vector2(1,1) 
	
	else:
		$AnimatedSprite.scale = Vector2(0.6,0.6) 
		$CollisionShape2D.scale = Vector2(0.6,0.6) 
		$VisibilityNotifier2D.scale = Vector2(0.6,0.6) 
