extends Node2D

@onready var score_label = $UI/ScoreLabel
@onready var game_over_label = $UI/GameOverLabel
@onready var restart_button = $UI/RestartButton
@onready var main_menu_button = $UI/MainMenuButton

func _ready():
	Global.score = 0
	update_score()
	game_over_label.hide()
	restart_button.hide()
	main_menu_button.hide()
	
	# Spawn worms periodically
	var worm_timer = Timer.new()
	worm_timer.wait_time = 5.0
	worm_timer.autostart = true
	worm_timer.connect("timeout", spawn_worm)
	add_child(worm_timer)

func _process(delta):
	update_score()

func update_score():
	score_label.text = "SCORE: %06d" % Global.score

func spawn_worm():
	var worm_scene = preload("res://scenes/Worm.tscn")
	var worm = worm_scene.instantiate()
	worm.position = Vector2(randi_range(100, 700), randi_range(100, 500))
	add_child(worm)

func game_over():
	game_over_label.show()
	restart_button.show()
	main_menu_button.show()
	get_tree().paused = true

func _on_restart_button_pressed():
	get_tree().paused = false
	Global.reset_score()
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	Global.reset_score()
	get_tree().change_scene_to_file("res://scenes/StartScreen.tscn")