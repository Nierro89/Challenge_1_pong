extends Node2D

#Variables
var countdownAnim : AnimationPlayer
var Ball: PackedScene = load("res://Scenes/ball.tscn")
signal resetPaddle
@onready var music_bg: AudioStreamPlayer = $music_bg


func _ready():
	startGame()
	music_bg.play()
	
func startGame():
	countdownAnim = get_tree().get_first_node_in_group("countdown_animation")
	var paddles = get_tree().get_nodes_in_group("paddle")
	
	for paddle in paddles:
		connect("resetPaddle", paddle.reset)
	
	Global.P1_Score = 0
	Global.P2_Score = 0
	resetPaddle.emit()
	
	startNextRound()
	

func startNextRound():
	if (Global.P1_Score == 5 or Global.P2_Score == 5):
		call_deferred("endGame")
		return
	countdownAnim.play("countdown")
	await countdownAnim.animation_finished
	spawnBall()
	
func endGame():
	get_tree().change_scene_to_file("res://Scenes/end screen.tscn")

func spawnBall():
	var direction = Vector2.from_angle(randf_range(0, 359))
	var newBall = Ball.instantiate()
	newBall.global_position = get_viewport().get_visible_rect().size / 2

	newBall.launch(direction)
	get_tree().root.get_child(1).add_child(newBall)
