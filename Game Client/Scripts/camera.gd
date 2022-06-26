extends Camera

onready var gun = $mauzer
onready var raycast = $RayCast

var gun_original_rotation = Vector3.ZERO
var relative_input = Vector2.ZERO

func _ready():
	gun_original_rotation = gun.rotation_degrees
	

	
func _input(event):
	if event is InputEventMouseMotion:
		relative_input = event.relative

func _process(delta):
	var rot = Vector3(
		gun_original_rotation.x,
		gun_original_rotation.y + relative_input.x*0.1,
		gun_original_rotation.z + relative_input.y*0.1)

	gun.rotation_degrees = gun.rotation_degrees.linear_interpolate(rot, delta*4)

