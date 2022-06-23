extends KinematicBody

# stats
var curHp: int = 10  # здоровье
var maxHp: int = 10

# physics
const moveSpeed: float = 13.0  # скорость игрока
const jumpForse: float = 50.0  # сила прыжка
const gravity: float = 100.0  # сила гравитации

# cam look
var minLookAngle: float = -90.0  # ограничение на опускание камеры
var maxLookAngle: float = 90.0  # ограничение на поднятие камеры
var lookSensitivity: float = 10.0  # чувствительность мыши

# vectors
var vel: Vector3 = Vector3()  # вектор скорости челикса
var mouseDelta: Vector2 = Vector2() #  чтобы следить насколько у нас сместилась мышь на новом фрейме

# components
onready var camera: Camera = get_node("Camera")  # положение камеры 
# в этой функции мы пропишем лок курсора по центру и спрячем курсор


var fv = {'Default': 60, 'ADS': 22}
const ADS_LERP = 20


onready var chel: KinematicBody = self


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# в настройках указали кнопки для управления теперь можно писать физику
func _physics_process(delta):  # функция обновляется 60 раз в секунду
	#if is_network_master():
		# тут мы сбрасываем вектор скорости чтобы когда мы отпускаем кнопку все работало нормально а не через жопу
		# ресет только х и z скорости чтобы прыгать можно было
		vel.x = 0
		vel.z = 0

		# теперь нужно чекать нажатия на кнопки wasd чтобы изменять скорость 
		var input = Vector2()
		if Input.is_action_pressed("move_forward"):
			input.y -= 1  # типа побежали вперед
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
		rpc_unreliable_id(1, 'update_player', global_transform)

remote func update_remote_player(transform):
	#if not is_network_master():
		global_transform = transform

# теперь будем чекать куда смотрит мышь
func _input(event):  # функция вызывается от любого инпута (мышь, клавиатура и тд)
	# проверяем вызван ли ивент мышью 
	if event is InputEventMouseMotion: # and is_network_master():
		mouseDelta = event.relative
