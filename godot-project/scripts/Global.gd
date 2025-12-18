extends Node

var score = 0

func add_score(points):
	score += points

func reset_score():
	score = 0

func game_over():
	# This will be called when game over condition is met
	pass