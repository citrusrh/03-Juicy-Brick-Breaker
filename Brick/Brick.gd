extends KinematicBody2D

onready var HUD = get_node("/root/Game/HUD")
onready var GameState = get_node("/root/GameState")
var row = 0
var col = 0

func _ready():
	update_color()

func update_color():
		if row == 0:
			$Color.color = Color8(224, 49, 49)
		if row == 1:
			$Color.color = Color8(253, 126, 20)
		if row == 2:
			$Color.color = Color8(255, 224, 102)
		if row == 3:
			$Color.color = Color8(148, 216, 45)
		if row == 4:
			$Color.color = Color8(34, 139, 230)
		if row == 5:
			$Color.color = Color8(132, 94, 247)
		if row == 6:
			$Color.color = Color8(190, 75, 219)

func emit_particle(pos):
	$Particles2D.global_position = pos
	$Particles2D.emitting = true


func die():
	GameState.score += 10
	GameState.bricks -= 1
	queue_free()
