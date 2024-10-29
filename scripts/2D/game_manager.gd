class_name GameManager extends Node

var _root_scene: Node2D = null
var _world_ref: GameplayWorld2D = null


func _ready() -> void:
	var current_scene = get_tree().get_current_scene()
	if current_scene is GameplayWorld2D:
		_root_scene = current_scene
		_world_ref = current_scene
	else:
		assert(current_scene is Node2D, "Scene root cannot be anything other than Node2D!")
		_root_scene = current_scene
		# Maybe this functionality should be wholly in the function
		var world := _find_gameplay_world(current_scene)
		assert(world != null, "Gameplay world not found in scene!")
		_world_ref = world
	#print(get_tree().get_current_scene().name)
	# fps lock 
	#Engine.max_fps = 60


func _find_gameplay_world(root: Node2D) -> GameplayWorld2D:
	var current_children: Array[Node] = root.get_children()
	var other_children: Array[Node] = []
	while current_children.size() > 0:
		for child in current_children:
			if child is GameplayWorld2D:
				return child
			other_children.append_array(child.get_children())
		current_children = other_children
	return null


func get_world_ref() -> GameplayWorld2D:
	return _world_ref


func get_root_scene() -> Node2D:
	return _root_scene
