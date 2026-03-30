extends State

var facingdirection : String
var attackCollisionShape : CollisionShape2D
@onready var attack_hit_box: Area2D = $"../../AttackHitBox"
const VFX_SLASH = preload("uid://cysi4dnimwgx5")

func Enter():
	super.Enter()
	character.UpdateAnimate()
	
	facingdirection = character.facingDirection
	var collisionShape_node = attack_hit_box.get_node("CollisionShape2D_"+facingdirection)
	if collisionShape_node:
		attackCollisionShape = collisionShape_node
	
func Update():
	super.Update()
	
	if parentStateMachine.animated_sprite_2d.frame == 2:
		attackCollisionShape.disabled = false
	elif parentStateMachine.animated_sprite_2d.frame == 5:
		attackCollisionShape.disabled = true
	
	if parentStateMachine.animated_sprite_2d.is_playing() == false:
		parentStateMachine.SwichTo("Idle")
	
func Ready():
	super.Ready()
	
	for child in attack_hit_box.get_children():
		var childCollisionShape = child as CollisionShape2D
		if childCollisionShape:
			childCollisionShape.disabled = true

func Exit():
	super.Exit()
	attackCollisionShape.set_deferred("disabled",true)

func _on_attack_hit_box_area_entered(area: Area2D) -> void:
	if WallCheck(area):
		var grassNode = area as Grass
		if grassNode:
			grassNode.GetCut()
		var enemyNode = area.get_parent() as enemyCharacter
		if enemyNode:
			character.StartCameraShake()
			enemyNode.GetHit(character.attackDamage , character.global_position)
			if enemyNode.isDead == false:
				SpawnSlashVFX(enemyNode.global_position)

func SpawnSlashVFX(pos : Vector2):
	var newVFX = VFX_SLASH.instantiate() as Node2D
	newVFX.global_position = pos + Vector2(0 , -25)
	get_tree().root.add_child(newVFX)

func WallCheck(target:Area2D):
	var player = owner as BaseCharacter
	var targetPos = target.global_position
	var space_state = player.get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(player.global_position,targetPos)
	query.exclude = [player.get_rid()]
	query.collision_mask = 1
	var result = space_state.intersect_ray(query)
	if result:
		return false
	return true
