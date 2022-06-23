extends RigidBody

const damage = 500
const speed = 300

func _ready():
	set_as_toplevel(true)
	

func SHOOT():
	apply_impulse(-transform.basis.z, transform.basis.z * speed)
	


func _on_Area_body_entered(body):
	if body.is_in_group('Enemy'):
		body.health -= damage
		
		queue_free()
	else: 
		queue_free()
		
		


func _on_Timer_timeout():
	queue_free()
