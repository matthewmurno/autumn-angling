extends CharacterBody2D

@export var speed = 50

enum State { IDLE, MOVE }
var state: State = State.IDLE

var time_in_state = 0.0
var last_facing_dir = Vector2(0,1)

@onready var animations = $animations

func change_state(newstate):
	if (newstate == state):
		return
	else:
		time_in_state = 0.0
		state = newstate


func _physics_process(delta):
	var move_dir = Input.get_vector("move_left", "move_right",  "move_up", "move_down")
	
	
	if (move_dir != Vector2.ZERO):
		last_facing_dir = move_dir.normalized()
		change_state(State.MOVE)
	else:
		change_state(State.IDLE)

	
	match state:
		State.IDLE:
			IdleData()
		State.MOVE:
			MoveData(delta, move_dir)
	
	move_and_slide()
	
func IdleData():
	velocity = Vector2.ZERO
	var anim_name := ""
	var flip_h = false
	
	if last_facing_dir.y < -0.5:
		anim_name = "idle6"
		flip_h = false
	elif last_facing_dir.y > 0.5:
		anim_name = "idle2"
		flip_h = false
	else:
		if last_facing_dir.x > 0.5:
			anim_name = "idle4"
			flip_h = true
		elif last_facing_dir.x < -0.5:
			anim_name = "idle4"
			flip_h = false
	

	if last_facing_dir.y > 0.5:
		if last_facing_dir.x > 0.2:
			anim_name = "idle3"
			flip_h = true
		elif last_facing_dir.x < -0.2:
			anim_name = "idle3"
			flip_h = false
	if last_facing_dir.y < -0.5:
		if last_facing_dir.x > 0.2:
			anim_name = "idle5"
			flip_h = true
		elif last_facing_dir.x < -0.2:
			anim_name = "idle5"
			flip_h = false
	
	animations.flip_h = flip_h	
	animations.set_animation(anim_name)
	animations.play()
	
func MoveData(delta, move_dir):
	var anim_name := ""
	var flip_h = false
	
	if move_dir.y < -0.5:
		anim_name = "walk6"
		flip_h = false
	elif move_dir.y > 0.5:
		anim_name = "walk2"
		flip_h = false
	else:
		if move_dir.x > 0.5:
			anim_name = "walk4"
			flip_h = true
		elif move_dir.x < -0.5:
			anim_name = "walk4"
			flip_h = false
	

	if move_dir.y > 0.5:
		if move_dir.x > 0.2:
			anim_name = "walk3"
			flip_h = true
		elif move_dir.x < -0.2:
			anim_name = "walk3"
			flip_h = false
	if move_dir.y < -0.5:
		if move_dir.x > 0.2:
			anim_name = "walk5"
			flip_h = true
		elif move_dir.x < -0.2:
			anim_name = "walk5"
			flip_h = false
	
	animations.flip_h = flip_h	
	animations.set_animation(anim_name)
	animations.play()
		
	
	velocity = (move_dir * speed)
	move_and_slide()
	

	
	
	
