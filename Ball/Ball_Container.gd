extends Node2D

onready var Ball = load("res://Ball/Ball.tscn")
onready var GameState = get_node("/root/GameState")
onready var rng = RandomNumberGenerator.new()
var balls = get_child_count()

func _ready():
	start_ball()
	

func _process(delta):
	balls = get_child_count()
	if balls == 0 and GameState.lives != 0:
		start_ball()
		GameState.lives -= 1
	if GameState.lives == 0:
		get_tree().change_scene("res://Levels/GameOver.tscn")

func start_ball():
	for c in get_children():
		c.queue_free()
	var ball = Ball.instance()
	ball.position = Vector2(512, 500)
	ball.name = "Ball"
	ball.apply_central_impulse(Vector2(rng.randi_range(-250, 250), rng.randi_range(-400, 0)))
	add_child(ball)
