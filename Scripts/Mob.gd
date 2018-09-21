extends RigidBody2D

export (int) var max_speed
export (int) var min_speed
var mob_types = ["walk" , "swim" , "fly"] 
func _ready():
	#randomize()##comentar esto luego de que se agregue en la escena main
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	

#esta funcion aparece al conectar la señal screen_exited del nodo visibility

func _on_Visibility_screen_exited():
	queue_free()
