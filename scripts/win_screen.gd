extends Control

func _ready():
	UiLayer.get_node("HUD").hideUI()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	UiLayer.show_win_screen(false)
	pass # Replace with function body.
