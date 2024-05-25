extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

@export var jumpForce = 300

func _on_body_entered(body):
	if body is Player: 
		animated_sprite.play("jump")
	body.jump(jumpForce)
	pass # Replace with function body.
