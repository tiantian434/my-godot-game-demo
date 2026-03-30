extends State

func UpdatePhysics(delta : float):
	super.UpdatePhysics(delta)

func Update():
	super.Update()
	character.UpdateAnimate()
	
	if character.inputDirection.length() > 0:
		parentStateMachine.SwichTo("Run")
		return
	
	if Input.is_action_just_pressed("Attack"):
		parentStateMachine.SwichTo("Attack")
