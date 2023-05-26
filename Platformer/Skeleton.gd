extends KinematicBody2D

export (int) var speed = 100
export (int) var jump_speed = -700
export (int) var gravity = 2050
export (int) var base_fall_velocity = 620

var velocity = Vector2.ZERO
var is_moving = false
var has_triggered = false
var entity_type = "Enemy"

func get_actor_node(node_name):
	return get_node("/root/EgPlatformer/Actors/" + node_name)

func get_spawn_node(node_name):
	return get_node("/root/EgPlatformer/Spawns/" + node_name)

func tick(delta):
	# Set Environment
	velocity.x = 0
	velocity.y += gravity * delta
	if velocity.y > base_fall_velocity:
		velocity.y = base_fall_velocity

	# Define Actions
	get_actor_node("Skel/Skeleton/Hitbox").position = get_actor_node("Skel/Skeleton/SkelSprite").position

	if get_node(".").position.x > get_actor_node("Player/PlayerBody").position.x:
		get_actor_node("Skel/Skeleton/SkelSprite").flip_h = false
		
		# Set is_moving to False if h
		if is_moving:
			get_actor_node("Skel/Skeleton/SkelSprite").play("walk")
			velocity.x -= speed
		else:
			get_actor_node("Skel/Skeleton/SkelSprite").play("stand")
	else:
		get_actor_node("Skel/Skeleton/SkelSprite").flip_h = true
		if is_moving:
			velocity.x += speed

	# If Egee lands on top of him, he should break into a pile of bones

	# Act on Actions
	velocity = move_and_slide(velocity, Vector2.UP)

func _physics_process(delta):
	tick(delta)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(".").position = get_spawn_node("Skel1").position


func _on_SkelMoveTrigger_body_entered(body):
	print(is_moving)
	is_moving = true
