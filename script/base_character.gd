extends CharacterBody2D
class_name BaseCharacter


@export var maxHealth = 100
@onready var currentHealth = maxHealth:
	set = set_currentHealth
var isDead = false
@export var attackDamage = 50
var isInvincible = false
var knockBackDirection : Vector2
var inputDirection :Vector2 = Vector2.ZERO
var facingDirection : String = "Down"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var animationToPlay : String
@onready var state_machine: StateMachine = $StateMachine
@onready var area_2d_body: Area2D = $Area2D_Body
@export var showDebugVisual = true

func set_currentHealth(value : int):
	currentHealth = clampi(value,0,maxHealth)
	if currentHealth == 0:
		isDead = true
		area_2d_body.set_deferred("monitoring",false)
		area_2d_body.set_deferred("monitorable",false)

func GetDirectionName() -> String:
	if inputDirection == Vector2.ZERO:
		return facingDirection
	if inputDirection.y > 0:
		facingDirection = "Down"
	elif inputDirection.y < 0:
		facingDirection = "Up"
	else:
		if inputDirection.x > 0:
			facingDirection = "Right"
		elif inputDirection.x < 0:
			facingDirection = "Left"
	return facingDirection

func UpdateAnimate():
	animated_sprite_2d.play(state_machine.currentState.name + "_" + GetDirectionName())


func GetHit(damage: int,fromPoint = Vector2.ZERO):
	if isDead || isInvincible:
		return
	StartBlink()
	currentHealth -= damage
	knockBackDirection = (global_position - fromPoint).normalized()
	
	if isDead:
		state_machine.SwichTo("Die")
	else:
		state_machine.SwichTo("Hurt")
		
		
func UpadateBlink(newValue : float):
	animated_sprite_2d.set_instance_shader_parameter("Blink",newValue)
	
func StartBlink():
	var blink_tween = get_tree().create_tween()
	blink_tween.tween_method(UpadateBlink,1.0,0,0.3)
	
	
	
func UpdateInvincibleEffect(newValue : bool):
	animated_sprite_2d.set_instance_shader_parameter("InvincibleEffect",newValue)
