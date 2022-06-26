extends AudioStreamPlayer


func _ready():
	pass
	
func _physics_process(delta):
	if self.is_playing():
		pass
	else:
		self.stop()
		
