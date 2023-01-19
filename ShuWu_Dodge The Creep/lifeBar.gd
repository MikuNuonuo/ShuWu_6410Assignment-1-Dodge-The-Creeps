extends TextureProgress


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Player_health_change(new_health):
	value = new_health  #assign health value to lifebar #SW.
