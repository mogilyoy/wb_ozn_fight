extends KinematicBody

# stats
var curHp: int = 10  # здоровье
var maxHp: int = 10

# physics
var moveSpeed: float = 10.0  # скорость игрока
var jumpForse: float = 50.0  # сила прыжка
var gravity: float = 98  # сила гравитации

# cam look
var minLookAngle: float = -90.0  # ограничение на опускание камеры
var maxLookAngle: float = 90.0  # ограничение на поднятие камеры
var lookSensitivity: float = 10.0  # чувствительность мыши

# vectors
var vel: Vector3 = Vector3()  # вектор скорости челикса
var mouseDelta: Vector2 = Vector2() #  чтобы следить насколько у нас сместилась мышь на новом фрейме
var mag = 30
# components
onready var camera: Camera = get_node("Camera")  # положение камеры 
# в этой функции мы пропишем лок курсора по центру и спрячем курсор
# оружие
onready var gun = $Camera/mauzer
onready var gun_anim = $Camera/mauzer/Anim
onready var gun_sound = $Camera/mauzer/BAX
# прицел оружия
onready var raycast = $Camera/RayCast
onready var camera_animation = $Camera/AnimationPlayer

const damage = 500

var fv = {'Default': 50, 'ADS': 15}
const ADS_LERP = 20


onready var chel: KinematicBody = self



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# в настройках указали кнопки для управления теперь можно писать физику
func _physics_process(delta):  # функция обновляется 60 раз в секунду
	# тут мы сбрасываем вектор скорости чтобы когда мы отпускаем кнопку все работало нормально а не через жопу
	# ресет только х и z скорости чтобы прыгать можно было
	vel.x = 0
	vel.z = 0
	lookSensitivity = 10
	moveSpeed = 13
	# теперь нужно чекать нажатия на кнопки wasd чтобы изменять скорость 
	var input = Vector2()
	if Input.is_action_pressed("move_forward"):
		input.y -= 1  # типа побежали вперед
		if camera_animation.is_playing():
			pass
		else:
			camera_animation.play("КАЧАЕТ")
	if Input.is_action_just_released("move_forward"):
		if camera_animation.is_playing():
			pass
		else:
			camera_animation.stop()
	if Input.is_action_pressed("move_backward"):
		input.y += 1   # типа побежали назад
	if Input.is_action_pressed("move_left"):
		input.x -= 1   # типа побежали налево
	if Input.is_action_pressed("move_right"):
		input.x += 1   # типа побежали направо
		
	# теперь нужно нормализовать движение по диагонали
	input = input.normalized()
	
	# теперь нужно получить движение вперед и направо, чтобы смещаться относительно камеры а не относительно глобальных х у и з
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	# теперь нужно создать вектор чтобы задать движение по новому направлению
	var relativeDir = (forward*input.y + right*input.x)  # вроде как произведение векторов
	
	# задаём скорость по х и з (мы не прыгаем)
	vel.x = relativeDir.x * moveSpeed
	vel.z = relativeDir.z * moveSpeed
	
	# задаем гравитацию 
	vel.y -= gravity * delta  # 60 раз в сеунду задаём скорость по у = гравитации
	
	# перемещаем игрока
	vel = move_and_slide(vel, Vector3.UP)
	
	# прыгаем 
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jumpForse	
		
		
	if Input.is_action_pressed("aim"):
		camera.fov = lerp(camera.fov, fv['ADS'], ADS_LERP * delta)
		lookSensitivity = 5
	else:
		camera.fov = lerp(camera.fov, fv['Default'], ADS_LERP * delta)
	if Input.is_action_just_pressed("shoot"):
		gun.GunAnimation(raycast.get_collision_point(), Vector3.UP)
		camera.rotation_degrees.x = lerp(camera.rotation_degrees.x, camera.rotation_degrees.x + rand_range(1, 3), rand_range(7,10)*delta)
		chel.rotation_degrees.y = lerp(chel.rotation_degrees.y, chel.rotation_degrees.y + rand_range(1,2), rand_range(2,3)*delta)
		
	if Input.is_action_pressed("speed"):
		vel.x = relativeDir.x * moveSpeed * 1.3
		vel.z = relativeDir.z * moveSpeed * 1.3
		vel = move_and_slide(vel, Vector3.UP)
		
		# camera.rotation_degrees.x = lerp(camera.rotation_degrees.x, camera.rotation_degrees.x + 2, 0.5)
		# chel.rotation_degrees.y = lerp(chel.rotation_degrees.y, chel.rotation_degrees.y + rand_range(-1, 1), rand_range(-1, 1))
		

func _process(delta):
	# повернуть камеру вокруг оси х
	# для поворота налево и направо будем поворачивать всё тело
	camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * delta  
	# умножаем на разницу изменения положения мыши по у на чуствительность и на дельту чтобы все наши движения были плавными
	
	# ограничить вращение камеры
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	
	# повернуть направо и налево (вращаем плеера вокруг оси у)
	rotation_degrees.y -= mouseDelta.x * lookSensitivity * delta 
	
	# сбрасываем вектор направления мыши
	mouseDelta = Vector2()
	
# теперь будем чекать куда смотрит мышь
func _input(event):  # функция вызывается от любого инпута (мышь, клавиатура и тд)
	# проверяем вызван ли ивент мышью 
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
	
	
	 
	
	
