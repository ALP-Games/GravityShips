class_name GameplayWorld2D extends Node2D

static var instance_count: int = 0

func _enter_tree() -> void:
	assert(instance_count < 1, "GameplayWorld2D should only have one instance!")
	instance_count += 1


func _exit_tree() -> void:
	assert(instance_count > 0, "GameplayWorld2D Instance count cannot be less that 1 now!")
	instance_count -= 1
