extends Control


func _ready():
	UiLayer.get_node("HUD").hideUI()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
