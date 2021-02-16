extends Particles

# Declare member variables here. Examples:
onready var time = get_node("Timer")
onready var anim = get_node("AnimationPlayer")


func _ready():
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("1"):
			anim.play("explosion")
			time.start()
	

func _on_Timer_timeout():
	self.queue_free()
