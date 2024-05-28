extends AudioStreamPlayer

const levelMusic = preload("res://assets/audio/psycho-logy.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	pass

func play_music_level():
	_play_music(levelMusic)
