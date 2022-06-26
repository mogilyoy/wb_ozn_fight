extends RigidBody

const damage = 500
const speed = 200

onready var raycast = $RayCast

func _ready():
	set_as_toplevel(true)
	

func SHOOT(collision_point, vector):
	self.look_at(collision_point, vector)
	apply_impulse(transform.basis.z, -transform.basis.z * speed)
	
func _physics_process(delta):
	if raycast.is_colliding():
		var body = raycast.get_collider()
		if body.is_in_group('Enemy'):
			body.health -= damage
			queue_free()
		else:
			queue_free()
	


func _on_Timer_timeout():
	queue_free()# Replace with function body.
