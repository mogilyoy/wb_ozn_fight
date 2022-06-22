extends Spatial

const ADS_LERP = 20

onready var animation = $Anim
onready var sound = $BAX
onready var muzzle = $Muzzle
onready var raycast = $RayCast
onready var bullet = preload("res://Scens/Пуля дура.tscn") # загружаем в игру пулю

export var default_positon: Vector3
export var ads_positon: Vector3

var fv = {'Default': 38.5, 'ADS': 18}

# Called when the node enters the scene tree for the first time.
func _ready():
	# camera.get_node(camera_path)
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		if raycast.is_colliding():
			var b = bullet.instance()
			muzzle.add_child(b)
			b.look_at(raycast.get_collision_point(), Vector3.UP)
			b.SHOOT()
			animation.stop()
			animation.play("Отдача")
			
	if Input.is_action_pressed("aim"):
		transform.origin = transform.origin.linear_interpolate(ads_positon, ADS_LERP * delta)
	else:
		transform.origin = transform.origin.linear_interpolate(default_positon, ADS_LERP * delta)
		
	
		



