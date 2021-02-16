extends Spatial

onready var shoot = preload("res://shoot.tscn")

func _ready():
	pass 
	

func _on_Timer_shoot_timeout():
	var shoot_now = shoot.instance()
	add_child(shoot_now)
