extends KinematicBody2D

export (int) var speed = 200
export (int) var jump_speed = -700
export (int) var gravity = 2050
export (int) var base_fall_velocity = 620

var velocity = Vector2.ZERO
var skel_velocity = Vector2.ZERO

var skel_fallen = false
var entity_type = "Player"

func get_actor_node(node_name):
	return get_node("/root/EgPlatformer/Actors/" + node_name)
	
func get_camera_node(node_name):
	return get_node("/root/EgPlatformer/Cameras/" + node_name)

func get_spawn_node(node_name):
	return get_node("/root/EgPlatformer/Spawns/" + node_name)
	
func get_trigger_node(node_name):
	return get_node("/root/EgPlatformer/Triggers/" + node_name)

func get_world_node(node_name):
	return get_node("/root/EgPlatformer/World/" + node_name)

func player_tick(delta):
	get_camera_node("PlayerCamera").position = get_node('.').position
	
	velocity.x = 0
	velocity.y += gravity * delta

	if Input.is_action_pressed("ui_cancel"):
		get_tree().paused = true

	#TODO: Have Egee moonwalk (reverse walk animation to move backwards slowly)
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_speed
	elif Input.is_action_pressed("ui_down"):
		get_node("PlayerSprite").play("sit")
	elif Input.is_action_pressed("ui_right"):
		velocity.x += speed
		get_node("PlayerSprite").flip_h = false
		get_node("PlayerSprite").play("move")
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		get_node("PlayerSprite").flip_h = true
		get_node("PlayerSprite").play("move")
	else:
		get_node("PlayerSprite").play("stand")

	# If he's anywhere other than on the floor, he is falling!
	if !is_on_floor():
		get_node("PlayerSprite").play("jump")

	if velocity.y > base_fall_velocity:
		velocity.y = base_fall_velocity

	velocity = move_and_slide(velocity, Vector2.UP)

#######################
#       Signals       #
#######################

func _on_Area2D_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	get_node(".").position = get_spawn_node("EastEntrance").position


func _on_East_Exit_body_entered(body):
	get_node(".").position = get_spawn_node("WestEntrance").position


func _on_BottomReset_body_entered(body):
	get_node(".").position = get_spawn_node("Respawn").position


func _on_SkelTrigger_body_entered(body):
	if not skel_fallen:
		get_actor_node("Skel/Skeleton").position = get_spawn_node("Skel2").position
		skel_fallen = true

func _on_Hitbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	pass

func _on_Hitbox_body_entered(body):
	if body.is_class('KinematicBody2D'):
		if body.entity_type && body.entity_type == "Player":
			print('you died')
			get_node(".").position = get_spawn_node("Respawn").position

#######################
#       Callers       #
#######################

func _ready():
	get_node(".").position = get_spawn_node("Spawn").position

func _physics_process(delta):
	player_tick(delta)
