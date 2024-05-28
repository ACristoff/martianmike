extends Node2D

@export var next_level: PackedScene = null
#song length 293
@export var level_time = 293

var player = null
var timer_node = null
var time_left = null
var winCon = false
@onready var start = $Start
@onready var exit = $Exit
@onready var death_zone = $Deathzone

@onready var hud = UiLayer.get_node("HUD")
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalTheme.play_music_level()
	player = get_tree().get_first_node_in_group("player")
	if player != null:
		player.global_position = start.get_spawn_pos()
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		# old way of connecting shit
		#trap.connect("touched_player", _on_trap_touched_player)
		# new way of connecting shit
		trap.touched_player.connect(_on_trap_touched_player)
	#print(traps)
	exit.body_entered.connect(_on_exit_body_entered)
	death_zone.body_entered.connect(_on_deathzone_body_entered)
	time_left = level_time
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()
	pass # Replace with function body.

#calling a signal every second, while negligible in this case seems like a bad way of doing this?
#Wouldn't it be more efficient to create a timer and simply get the time left from there?
func _on_level_timer_timeout():
	if winCon == false:
		time_left -= 1
		#print(hud)
		hud.set_time_label(time_left)
		#print(time_left)
		if time_left <= 0:
			reset_player()
			time_left = level_time
			hud.set_time_label("Game Over!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	pass



func _on_deathzone_body_entered(body):
	reset_player()
	pass # Replace with function body.


func _on_trap_touched_player():
	reset_player()
	pass # Replace with function body.

func reset_player():
	player.velocity = Vector2.ZERO
	player.global_position = start.get_spawn_pos()


func _on_spikeball_touched_player():
	pass # Replace with function body.

func _on_exit_body_entered(body):
	if body is Player:
		if next_level != null:
			exit.animate()
			player.active = false
			winCon = true
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_packed(next_level)
	pass
