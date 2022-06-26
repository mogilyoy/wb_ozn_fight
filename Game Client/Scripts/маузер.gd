extends Spatial


const ADS_LERP = 20
const damage = 500
const anim_speed = 1

onready var animation = $Anim
onready var sound = $BAX
onready var muzzle = $Muzzle
onready var bullet = preload("res://Scens/Пуля дура.tscn")

var mag = 30

export var default_positon: Vector3
export var ads_positon: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	# camera.get_node(camera_path)
	pass

func _physics_process(delta): 
	if Input.is_action_pressed("aim"):
		transform.origin = transform.origin.linear_interpolate(ads_positon, ADS_LERP * delta)
	else:
		transform.origin = transform.origin.linear_interpolate(default_positon, ADS_LERP * delta)
		
	if Input.is_action_just_pressed("reload"):
		mag = 30	

func GunAnimation(collision_point, vector):
	if animation.is_playing():
			pass
	else:
			var b = bullet.instance()
			muzzle.add_child(b)
			b.SHOOT(collision_point, vector)
			animation.play("Отдача")
			sound.stop()
			sound.play()
	
	
