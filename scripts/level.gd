extends Node2D

@export var next_level: PackedScene = null

var player = null
@onready var start = $Start
@onready var exit = $Exit
@onready var death_zone = $Deathzone
# Called when the node enters the scene tree for the first time.
func _ready():
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
	pass # Replace with function body.


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
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_packed(next_level)
	pass
