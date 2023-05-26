extends Node

func get_actor_node(node_name, scene_name='EgPlatformer'):
	return get_node("/root/"+scene_name+"/Actors/" + node_name)
	
func get_camera_node(node_name, scene_name='EgPlatformer'):
	return get_node("/root/"+scene_name+"/Cameras/" + node_name)

func get_spawn_node(node_name, scene_name='EgPlatformer'):
	return get_node("/root/"+scene_name+"/Spawns/" + node_name)
	
func get_trigger_node(node_name, scene_name='EgPlatformer'):
	return get_node("/root/"+scene_name+"/Triggers/" + node_name)

func get_world_node(node_name, scene_name='EgPlatformer'):
	return get_node("/root/"+scene_name+"/World/" + node_name)

func get_gui_node(node_name, scene_name='TitleScreen'):
	return get_node("/root/"+scene_name+"/World/" + node_name)
