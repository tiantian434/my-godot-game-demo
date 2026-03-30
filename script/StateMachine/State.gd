extends Node
class_name State

var parentStateMachine : StateMachine
var character : BaseCharacter

@warning_ignore("unused_parameter")
func UpdatePhysics(delta : float):
	#print(name + "is updating physics")
	pass

func Update():
	if character.showDebugVisual:
		if parentStateMachine.debug_label:
			parentStateMachine.debug_label.text = name + '/' + str(character.currentHealth)
	else:
		parentStateMachine.debug_label.visible = false

func Enter():
	pass

func Exit():
	pass

func Ready():
	pass
