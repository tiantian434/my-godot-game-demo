extends State


const SPEED = 300
const ACCELERATION = 15

func UpdatePhysics(delta : float):
	
	character.velocity = character.velocity.lerp(character.inputDirection * SPEED,ACCELERATION * delta)
	character.move_and_slide()

func Update():
	super.Update()
	character.UpdateAnimate()
	
	if character.inputDirection == Vector2.ZERO:
		parentStateMachine.SwichTo("Idle")
		return
		
	if Input.is_action_just_pressed("Attack"):
		parentStateMachine.SwichTo("Attack")
