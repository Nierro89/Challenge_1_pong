extends MarginContainer


@onready var mm_music: AudioStreamPlayer = $mm_bkgnd
@onready var hover : AudioStreamPlayer = $hover


func _ready():
	mm_music.play()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_play_mouse_entered():
	hover.play()


func _on_quit_mouse_entered() -> void:
	hover.play()
