extends KinematicBody

const CAMERA_ROTATION_SPEED = 0.0025
const CAMERA_X_ROT_MIN = -40
const CAMERA_X_ROT_MAX = 30

const MOVE_SPEED = 15
const JUMP_FORCE = 30
const GRAVITY = 0.98
const MAX_FALL_SPEED = 30

var camera_x_rot = 0.0

var y_velo = 0

onready var anim = get_node("AnimationPlayer")
onready var hitv1 = preload("res://explosion.tscn")
onready var magic = preload("res://particle.tscn")
onready var buff = preload("res://buff.tscn")

var character

func _input(event):
	if event is InputEventMouseMotion:
		#from tps demo
		$camera_pivot.rotate_y( -event.relative.x * CAMERA_ROTATION_SPEED )
		$camera_pivot.orthonormalize() # after relative transforms, camera needs to be renormalized
		camera_x_rot = clamp(camera_x_rot + event.relative.y * CAMERA_ROTATION_SPEED,deg2rad(CAMERA_X_ROT_MIN), deg2rad(CAMERA_X_ROT_MAX) )
		$camera_pivot.rotation.x =  camera_x_rot
		# end

	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _ready():
	character = get_node("player_armature")
	
	
	
func _physics_process(delta):
	
	var move_vec = Vector3()
	
	
	if Input.is_action_pressed("move_fw"):
		move_vec.z -= 1

	if Input.is_action_pressed("move_bw"):
		move_vec.z += 1

	if Input.is_action_pressed("move_r"):
		rotation.y -= .03

	if Input.is_action_pressed("move_l"):
		rotation.y += .03

	if Input.is_action_just_pressed("1"):
		var explosion = hitv1.instance()
		add_child(explosion)

	if Input.is_action_just_pressed("2"):
		var particle = magic.instance()
		add_child(particle)
	
	if Input.is_action_just_pressed("3"):
		var buff_now = buff.instance()
		add_child(buff_now)
	
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_vec *= MOVE_SPEED
	move_vec.y = y_velo
	
	
	move_and_slide(move_vec, Vector3(0, 1, 0))
	

	# From tps Demo
	var grounded = is_on_floor()
	y_velo -= GRAVITY
	var just_jumped = false
	if grounded and Input.is_action_just_pressed("jump"):
		just_jumped = true
		y_velo = JUMP_FORCE
	if grounded and y_velo <= 0:
		y_velo = -0.1
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED
	# end
	
	
	
	if just_jumped:
		play_anim("p_jump")
	elif grounded:
		if Input.is_action_pressed("1"):
			anim.play("p_hit_v1")
		elif Input.is_action_pressed("2"):
			play_anim("p_throw")
		elif Input.is_action_pressed("3"):
			play_anim("p_buff")
		elif move_vec.x == 0 and move_vec.z == 0:
			play_anim("p_stand-loop")
		else:
			play_anim("p_run-loop")


func play_anim(name):
	if anim.current_animation == name:
		return
	anim.play(name)

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
