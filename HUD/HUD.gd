extends Control

onready var GameState = get_node("/root/GameState")

func _process(delta):
	$Lives.text = "Lives: " + String(GameState.lives)
	$Score.text = "Score: " + String(GameState.score)
	if GameState.bricks == 0:
		get_tree().change_scene("res://Levels/NextLevel.tscn")
		GameState.bricks = 56

