extends MeshInstance

onready var raycast = $RayCast
const damage = 500

func _ready():
	pass
	
func _physics_process(delta):
	if raycast.is_colliding():
		var body = raycast.get_collider()
		body.health -= damage
		
	# if Input.is_action_just_pressed("reload"):
		
