extends Area2D
export (int) var speed #la palabra export nos permite modificar la prop
#propiedad desde el inspector de godot
var screensize #Tamaño de la ventana
signal hit
func _ready():
	screensize = get_viewport_rect().size
	#hide()#oculta al jugador al iniciar el juego
	
func _process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1		
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1		
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1		
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	# el simbolo $ es una abreviatura de``get_node()``. 
	#En el código anterior, $AnimatedSprite.play() es lo mismo que:
	#get_node("AnimatedSprite").play()
	
	#* Revisaremos cada entrada y sumaremos o restaremos de la velocity (velocidad) 
	#para obtener la dirección total. Por ejemplo, si mantienes right (derecha) y down 
	#(abajo) al mismo tiempo, el resultado del vector velocity será (1,1). 	
	#En este caso, como estamos agregando un movimiento horizontal y vertical, 
	#el jugador podrá moverse más rápido que si solo se estuviese moviendo
	# horizontalmente.

	#Podemos prevenir eso normalizando velocity, lo que significa que su longitud 
	#será 1, y multiplicando por la velocidad total deseada. 
	#Esto hará que el movimiento diagonal no sea más rápido.*
	position += velocity * delta#actualiza la posicion
	position.x = clamp(position.x, 0, screensize.x)#evita que se salga de la pantalla en x
	position.y = clamp(position.y, 0, screensize.y)#evita que se salga de la pantalla en y
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		#$AnimatedSprite.flip_h = false
		$AnimatedSprite.flip_h = velocity.x < 0
		#if velocity.x > 0:
		#	$AnimatedSprite.flip_h = false
		#else:
		#	$AnimatedSprite.flip_h = true
	if velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		#if velocity.y > 0:
		#	$AnimatedSprite.flip_v = false
		#else:
		#	$AnimatedSprite.flip_v = true

func _on_Player_body_entered(body):#cuando choca con un enemigo rigidbody2d
	hide()#oculta al jugador
	emit_signal("hit")#emite la señal hit
	$CollisionShape2D.disabled = true#desactiva las colisiones para evitar mas de un hit
	
func start(pos):
	position=pos
	show()
	$CollisionShape2D.disabled = false