extends KinematicBody2D

onready var paddle_size = $Color.rect_size
onready var Ball = load("res://Ball/Ball.tscn")
onready var HUD = get_node("/root/Game/HUD")

func _ready():
	update_color()


func update_color():
	$Color.color = Color8(255, 255, 255)

#func emit_particle(pos):
#	if HUD.particle_paddle:
#		$Particles2D.global_position = pos
#		$Particles2D.emitting = true
#	else:
#		$Particles2D.emitting = false

func _on_HUD_changed():
	update_color()

func _physics_process(_delta):
	var target = get_viewport().get_mouse_position().x
	target = clamp(target, 0, get_viewport().size.x - paddle_size.x)

	position.x = target
