extends BaseCharacter
class_name PlayerCharacter

@onready var camera_2d: Camera2D = $Camera2D
var cameraShakeNoiseMap : FastNoiseLite
var cameraShakeDuration = 0.3
var cameraShakeIntensityStart = 10
var cameraShakeIntensityEnd = 0.0


var currentCoin = 0:
	set = set_currenCoin

func _unhandled_input(_event: InputEvent) -> void:
	inputDirection = Input.get_vector("Left","Right","Up","Down")

func set_currentHealth(value : int):
	super.set_currentHealth(value)
	
	GameManager.PlayerHealthUpdate(currentHealth,maxHealth)
	
	if isDead:
		GameManager.PlayerIsDead()

func collectedCoin(healthValue : int,coinValue : int):
	currentHealth += healthValue
	currentCoin += coinValue

func set_currenCoin(value):
	currentCoin = value
	GameManager.PlayerCoinUpdated(currentCoin)

func StartCameraShake():
	if cameraShakeNoiseMap == null:
		cameraShakeNoiseMap = FastNoiseLite.new()
	
	var cameraShakeTween = get_tree().create_tween()
	cameraShakeTween.tween_method(ApplyCameraShake,cameraShakeIntensityStart,cameraShakeIntensityEnd,cameraShakeDuration)



func ApplyCameraShake(intensity : float):
	var offset = cameraShakeNoiseMap.get_noise_1d(Time.get_ticks_msec()) * intensity
	camera_2d.offset.x = offset
	camera_2d.offset.y = offset
