extends Spatial

onready var time = get_node("Timer")


func _ready():
	pass
	
	
func _process(delta):
	
	if Input.is_action_just_pressed("2"):
			time.start()
	

func _on_Timer_timeout():
	self.queue_free()
