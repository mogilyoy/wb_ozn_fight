extends KinematicBody

var vel: Vector3 = Vector3()  # вектор скорости челикса
var gravity: float = 20.0
var health = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		queue_free()
		
func _physics_process(delta):
	vel.y -= gravity * delta
	vel.x = rand_range(-10,10)
	vel.z = rand_range(-10,10)
	vel = move_and_slide(vel, Vector3.UP)
	
