extends State

func Enter():
	super.Enter()
	character.UpdateAnimate()
	
func UpdatePhysics(delta : float):
	super.UpdatePhysics(delta)
	if parentStateMachine.animated_sprite_2d.frame == 0:
		character.move_and_collide(character.knockBackDirection * delta * 400)
