extends KinematicBody

onready var girl = $GGirl
onready var girl_anim = $GGirl/AnimationPlayer

var vel: Vector3 = Vector3()  # вектор скорости челикса
var gravity: float = 20.0
var health = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	vel.z = rand_range(-10,10)
	vel.x = rand_range(-10,10)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		queue_free()
		
func _physics_process(delta):
	girl_anim.play('ArmatureAction')
	vel.y -= gravity * delta
	vel = move_and_slide(vel, Vector3.UP)
	if vel.z < 2 and vel.z > -2:
		vel.z = rand_range(-10, 10)
		self.rotate_y(vel.z)
		
	if vel.x <2 and vel.x > -2:
		vel.x = rand_range(-10, 10)
		self.rotate_y(vel.x)
	
	
