extends Node2D

var follow_target = null
var follow_distance = 20
var speed = 50

func _process(delta):
	if follow_target:
		var direction = (follow_target.position - position).normalized()
		rotation = direction.angle()
		
		var distance = position.distance_to(follow_target.position)
		if distance > follow_distance:
			position += direction * speed * delta