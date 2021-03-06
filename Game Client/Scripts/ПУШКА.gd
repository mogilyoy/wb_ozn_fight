extends Spatial

const ADS_LERP = 20
const anim_speed = 1

onready var animation = $Anim
onready var sound = $BAX
onready var bullet = preload("res://Scens/Пуля дура.tscn") # загружаем в игру пулю
onready var muzzle  = $Muzzle

export var default_positon: Vector3
export var ads_positon: Vector3

onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	# camera.get_node(camera_path)
	pass

func _physics_process(delta): 
	if Input.is_action_pressed("aim"):
		transform.origin = transform.origin.linear_interpolate(ads_positon, ADS_LERP * delta)
	else:
		transform.origin = transform.origin.linear_interpolate(default_positon, ADS_LERP * delta)
	
	if Input.is_action_pressed("move_forward"):
		if animation.is_playing():
			pass
		else:
			animation.play("Шаг")
	if Input.is_action_just_released("move_forward"):
		if animation.is_playing():
			pass
		else:
			animation.stop()
	
			
func GunAnimation(collision_point):
	if animation.is_playing():
			pass
	else:
			animation.play("Отдача")


		
