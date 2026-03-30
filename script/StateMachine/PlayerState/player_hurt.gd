extends State

func Enter():
	super.Enter()
	character.UpdateAnimate()
	character.StartCameraShake()
	character.isInvincible = true
	character.UpdateInvincibleEffect(true)
	await get_tree().create_timer(2).timeout
	character.isInvincible = false
	character.UpdateInvincibleEffect(false)

func UpdatePhysics(delta : float):
	super.UpdatePhysics(delta)
	
	if parentStateMachine.animated_sprite_2d.frame_progress == 1:
		parentStateMachine.SwichTo("Idle")
	
	if parentStateMachine.animated_sprite_2d.frame == 0:
		character.move_and_collide(character.knockBackDirection * delta * 400)
