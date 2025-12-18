extends RigidBody2D

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.queue_free()
		queue_free()
		Global.add_score(10)
	elif body.name == "Wall":
		queue_free()