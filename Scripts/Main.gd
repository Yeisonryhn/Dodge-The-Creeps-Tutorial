extends Node

export (PackedScene) var Mob
var score
func _ready():
	randomize()
	#score=0
	#$ScoreTimer.start()
	#$MobTimer.start()




func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$GameOver.play()

func new_game():
	score=0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")
	$Music.play()
	


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())#seleciona una ubicacion al azar en mobpath
	var mob = Mob.instance();
	add_child(mob)#agrega mob a la escena main
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2 # la direcion del mob es hacia adentro
	mob.position= $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4,PI/4)
	mob.rotation= direction
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed,mob.max_speed),0).rotated(direction))

func _on_ScoreTimer_timeout():
	score = score + 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()


func _on_HUD_start_game():
	new_game()
