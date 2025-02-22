class_name HungryPlanet extends RigidBody2D

@onready var mouth: Area2D = $Mouth
@onready var chewable: Area2D = $Chewable
@onready var close_to_bite: Area2D = $CloseToBite
@onready var gravity_field: Area2D = $Gravity
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var chomp_animation_playing: bool = false
var edible_bodies_in_range: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close_to_bite.body_entered.connect(_entered_range)
	close_to_bite.body_exited.connect(_exited_range)
	mouth.body_entered.connect(_body_entered_mouth)
	gravity_field.body_exited.connect(_object_left_gravity_field)
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play("idle")
	#animation_tree.animation_started
	#animation_tree.is_playing


func _object_left_gravity_field(node: Node2D) -> void:
	# or maybe need to use destruction component since that one might have effects?
	node.queue_free()


func _on_animation_finished(animation_name: String) -> void:
	match animation_name:
		"chomp":
			chomp_animation_playing = false
			if edible_bodies_in_range > 0:
				animation_player.play("ready")
			else:
				animation_player.play("idle")
		"ready":
			if edible_bodies_in_range > 0:
				for body in mouth.get_overlapping_bodies():
					if body != self and DestructionComponent.core().get_from(body):
						_chomp_chewable()
						return


func _entered_range(node: Node2D) -> void:
	if DestructionComponent.core().get_from(node):
		if edible_bodies_in_range == 0 and not chomp_animation_playing:
			animation_player.play("ready")
		edible_bodies_in_range += 1


func _exited_range(node: Node2D) -> void:
	if DestructionComponent.core().get_from(node):
		_remove_body(true)


func _remove_body(play_animation: bool) -> void:
	edible_bodies_in_range -= 1
	if play_animation and edible_bodies_in_range == 0:
		animation_player.play("idle")


func _body_entered_mouth(node: Node2D) -> void:
	if chomp_animation_playing:
		return
	if node != self and DestructionComponent.core().get_from(node):
		_chomp_chewable()


func _chomp_chewable() -> void:
	animation_player.play("chomp")
	chomp_animation_playing = true
	var overlaping_bodies = chewable.get_overlapping_bodies()
	for body in overlaping_bodies:
		var eat := func (component: DestructionComponent):
			component.destroy()
			_remove_body(false)
		DestructionComponent.core().invoke_on_component(body, eat)
