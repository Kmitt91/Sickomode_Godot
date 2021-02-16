extends Spatial

onready var time = get_node("Timer")
onready var anim = get_node("AnimationPlayer")

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("2"):
		anim.play("throw_ready")

func _on_Timer_timeout():
	self.queue_free()
