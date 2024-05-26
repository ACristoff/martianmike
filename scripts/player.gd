extends CharacterBody2D
class_name Player

@export var speed = 125.0
@export var gravity = 400
@export var jump_force = 200
@export var coyote_time = 0.3
var coyote_timer = 0.3


@onready var animated_sprite = $AnimatedSprite2D

func jump(force):
	velocity.y = -force
	coyote_timer = 0

func _physics_process(delta):
	#if Input.is_action_just_pressed("jump") && is_on_floor():
	if Input.is_action_just_pressed("jump") && coyote_timer > 0:
		jump(jump_force)
	if is_on_floor() == false:
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
		coyote_timer -= 1 * delta
		#print("is not on floor test")
	if is_on_floor_only() && !Input.is_action_just_pressed("jump"): 
		coyote_timer = coyote_time
	var direction = Input.get_axis("move_left", "move_right")
	#print(direction)
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
	velocity.x = direction * speed
	move_and_slide()
	#print(coyote_timer)
	update_animations(direction)

func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
		pass
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
		pass
	pass

func _ready():
	
	pass

#func _process(delta):
	##if Input.is_action_just_pressed("move_right"):
	#if Input.is_action_pressed("move_right"):
		#animated_sprite.play("run")
	#else:
		#animated_sprite.play("idle")

## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
