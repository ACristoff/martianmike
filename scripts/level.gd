extends Node2D

@onready var player = $Player
@onready var start_position = $startPosition
# Called when the node enters the scene tree for the first time.
func _ready():
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
