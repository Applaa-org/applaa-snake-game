extends Node2D

@export var segment_count = 10
@export var segment_spacing = 20

var segments = []
var direction = Vector2.RIGHT
var speed = 30

@onready var segment_scene = preload("res://scenes/WormSegment.tscn")

func _ready():
	create_segments()
	
	# Set initial positions
	for i in range(segment_count):
		var segment = segments[i]
		segment.position = position - direction * segment_spacing * i

func _process(delta):
	# Move head
	position += direction * speed * delta
	
	# Change direction randomly or when hitting walls
	if randf() < 0.01 or is_colliding():
		change_direction()

func create_segments():
	for i in range(segment_count):
		var segment = segment_scene.instantiate()
		if i == 0:
			segment.get_node("Sprite2D").modulate = Color(0.2, 0.8, 0.2)  # Head color
		else:
			segment.get_node("Sprite2D").modulate = Color(0.1, 0.6, 0.1)  # Body color
		add_child(segment)
		segments.append(segment)
		
		# Set follow target for each segment
		if i > 0:
			segment.follow_target = segments[i-1]

func change_direction():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func is_colliding():
	# Simple boundary check
	return position.x < 50 or position.x > 750 or position.y < 50 or position.y > 550

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		Global.game_over()