extends Camera

var fv = {'Default': 38.5, 'ADS': 18}
const ADS_LERP = 20
export var camera_path: NodePath
var camera: Camera

func _ready():
	camera = get_node(camera_path)# Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("aim"):
		camera.fov = lerp(camera.fov, fv['ADS'], ADS_LERP * delta)
	else:
		camera.fov = lerp(camera.fov, fv['Default'], ADS_LERP * delta)
	if Input.is_action_pressed("shoot"):
		var spam = camera.rotation_degrees.x
		camera.rotation_degrees.x = lerp(camera.rotation_degrees.x, camera.rotation_degrees.x + 5, 0.5)
		
		
