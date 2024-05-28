extends Control

func hideUI():
	hide()
	pass

func showUI():
	show()


#func _ready():
	#hideUI()

func set_time_label(value):
	$TimeLabel.text = str(value)
