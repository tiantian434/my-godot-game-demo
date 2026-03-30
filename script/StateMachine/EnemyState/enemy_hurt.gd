extends State

func Enter():
	super.Enter()
	character.UpdateAnimate()
	
func Update():
	super.Update()
	if character.animated_sprite_2d.frame_progress == 1:
		parentStateMachine.SwichTo("Idle")


func UpdatePhysics(delta : float):
	super.UpdatePhysics(delta)
	if parentStateMachine.animated_sprite_2d.frame_progress == 0:
		character.move_and_collide(character.knockBackDirection * delta * 200)
	
