extends CharacterBody2D

const SPEED = 200
const BULLET_SPEED = 400
var direction = Vector2.UP
var can_shoot = true

@onready var bullet_scene = preload("res://scenes/Bullet.tscn")
@onready var muzzle_flash = $MuzzleFlash

func _ready():
	muzzle_flash.hide()

func _physics_process(delta):
	# Handle movement
	var input_direction = Vector2.ZERO
	input_direction.x = Input.get_axis("ui_left", "ui_right")
	input_direction.y = Input.get_axis("ui_up", "ui_down")
	
	if input_direction != Vector2.ZERO:
		direction = input_direction.normalized()
		rotation = direction.angle()
	
	velocity = input_direction * SPEED
	move_and_slide()
	
	# Handle shooting
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()

func shoot():
	can_shoot = false
	muzzle_flash.show()
	
	var bullet = bullet_scene.instantiate()
	bullet.position = position + direction * 20
	bullet.rotation = direction.angle()
	bullet.linear_velocity = direction * BULLET_SPEED
	
	get_tree().get_root().get_node("Main").add_child(bullet)
	
	await get_tree().create_timer(0.1).timeout
	muzzle_flash.hide()
	can_shoot = true