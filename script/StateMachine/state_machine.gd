extends Node
class_name StateMachine

var currentState : State
@onready var debug_label: Label = $"../DebugLabel"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"


func _ready() -> void:
	for child in get_children():
		var childState = child as State
		childState.parentStateMachine = self
		childState.character = get_parent()
		childState.Ready()
		
	currentState = get_child(0)
	currentState.Enter()
	


func _physics_process(delta: float) -> void:
	currentState.UpdatePhysics(delta)
	

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	currentState.Update()

func SwichTo(TargetState : String) :
	var nextStateNode = get_node(TargetState)
	
	if !nextStateNode:
		print ("can not get Node")
		return
	
	currentState.Exit()
	currentState = nextStateNode
	currentState.Enter()
	
	
	
	
	
