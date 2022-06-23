extends Camera

var fv = {'Default': 38.5, 'ADS': 15}
const ADS_LERP = 20
export var camera_path: NodePath
export var gun_path: NodePath
var camera: Camera
var gun: Spatial

func _ready():
	camera = get_node(camera_path)# Replace with function body.
	gun = get_node(gun_path)

func _physics_process(delta):
	if Input.is_action_pressed("aim"):
		camera.fov = lerp(camera.fov, fv['ADS'], ADS_LERP * delta)
	else:
		camera.fov = lerp(camera.fov, fv['Default'], ADS_LERP * delta)
	if Input.is_action_just_pressed("shoot"):
		gun.ShootGun()
		var spam = camera.rotation_degrees.x
		camera.rotation_degrees.x = lerp(camera.rotation_degrees.x, camera.rotation_degrees.x + 3, 1.5)
		camera.rotation_degrees.y = lerp(camera.rotation_degrees.y, camera.rotation_degrees.y + rand_range(-2, 2), rand_range(-2, 2))
		
		
