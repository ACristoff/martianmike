extends Node2D

@onready var player = $Player
@onready var start_position = $startPosition
# Called when the node enters the scene tree for the first time.
func _ready():
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		# old way of connecting shit
		#trap.connect("touched_player", _on_trap_touched_player)
		# new way of connecting shit
		trap.touched_player.connect(_on_trap_touched_player)
	#print(traps)
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
	player.global_position = start_position.global_position


func _on_spikeball_touched_player():
	pass # Replace with function body.
