extends Control

const Heplers = preload("Helpers.gd")

func get_gui_node(node_name, scene_name='TitleScreen'):
	return get_node("/root/"+scene_name+"/" + node_name)

var is_options = false
var my_position = Vector2.ZERO
var current_selection = 0
var available_selection = {
	0: Vector2(390, 421),
	1: Vector2(390, 456),
	2: Vector2(390, 493),
}

var available_selection_options = {
	0: Vector2(370, 283),
	1: Vector2(370, 319),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	get_gui_node('SelectorArrow').position = available_selection[current_selection]
	
func main_menu_tree():
	if Input.is_action_just_pressed("ui_accept"):
		if current_selection == 0:
			get_tree().change_scene("res://Root.tscn")
		elif current_selection == 1:
			is_options = true
			get_gui_node('TitleScreen').visible = false
			get_gui_node('SelectorArrow').position = available_selection_options[0]
			current_selection = 0
			return
		elif current_selection == 2:
			get_tree().quit()
	
func options_menu_tree():
	if Input.is_action_just_pressed("ui_accept"):
		if current_selection == 0:
			get_gui_node('SelectorArrow').visible = false
		elif current_selection == 1:
			is_options = false
			get_gui_node('TitleScreen').visible = true
			get_gui_node('SelectorArrow').position = available_selection[0]
			current_selection = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# First, handle any input.
	if is_options:
		options_menu_tree()
	else:
		main_menu_tree()

	# Next, figure out where the user wants to go
	var desired_selection = current_selection
	if Input.is_action_just_pressed("ui_up"):
		desired_selection = current_selection - 1
	elif Input.is_action_just_pressed("ui_down"):
		desired_selection = current_selection + 1

	if is_options:
		if ! desired_selection in [0, 1]:
			return
		get_gui_node('SelectorArrow').position = available_selection_options[desired_selection]
	else:
		if ! desired_selection in [0, 1, 2]:
			return
		get_gui_node('SelectorArrow').position = available_selection[desired_selection]
	
	current_selection = desired_selection
