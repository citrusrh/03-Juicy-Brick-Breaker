extends RigidBody2D

export var max_speed = 400.0
export var min_speed = 100.0
onready var HUD = get_node("/root/Game/HUD")
onready var camera = get_node("/root/Game/Camera")
var ballColor = 0

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)
	update_color()


func update_color():
	if ballColor % 2 == 0:
		$Color.color = Color8(255, 255, 255)
	else:
		$Color.color = Color8(1, 1, 1)


func emit_particle(pos):
	$Particles2D.global_position = pos
	$Particles2D.emitting = true
	
func screen_shake(amount):
	camera.add_trauma(amount)
		

func play_sound(sound):
	sound.play()


func _physics_process(_delta):
	var currPos = position
	currPos.x += 10
	currPos.y += 10
	emit_particle(currPos)
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.name == "Walls":
			play_sound(get_node("/root/Game/Wall"))
		if body.name == "Paddle":
			play_sound(get_node("/root/Game/Paddle"))
		if body.has_method("emit_particle"):
			body.emit_particle(global_position)
		if body.is_in_group("Brick"):
			screen_shake(5)
			ballColor += 1
			update_color()
			play_sound(get_node("/root/Game/Brick"))
			if body.get_child(0).color == Color8(190, 75, 219):
				body.die()
			elif body.get_child(0).color == Color8(132, 94, 247):
				body.get_child(0).color = Color8(190, 75, 219)
			elif body.get_child(0).color == Color8(34, 139, 230):
				body.get_child(0).color = Color8(132, 94, 247)
			elif body.get_child(0).color == Color8(148, 216, 45):
				body.get_child(0).color = Color8(34, 139, 230)
			elif body.get_child(0).color == Color8(255, 224, 102):
				body.get_child(0).color = Color8(148, 216, 45)
			elif body.get_child(0).color == Color8(253, 126, 20):
				body.get_child(0).color = Color8(255, 224, 102)
			elif body.get_child(0).color == Color8(224, 49, 49):
				body.get_child(0).color = Color8(253, 126, 20)
		if body.is_in_group("DeathPlane"):
			self.queue_free()


func _integrate_forces(state):
	if abs(state.linear_velocity.x) < min_speed:
		state.linear_velocity.x = sign(state.linear_velocity.x) * min_speed
	if abs(state.linear_velocity.y) < min_speed:
		state.linear_velocity.y = sign(state.linear_velocity.y) * min_speed
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed
