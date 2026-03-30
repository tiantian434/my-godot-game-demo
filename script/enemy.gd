extends BaseCharacter
class_name enemyCharacter

@onready var line_2d: Line2D = $Line2D
var player : BaseCharacter
var playerDirection : Vector2
var playerAngle : float

func _ready() -> void:
	player = get_tree().root.get_node("ScenceNode/Level/Player")


func _process(_delta: float) -> void:
	playerDirection = player.global_position - global_position
	playerDirection = playerDirection.normalized()
	if showDebugVisual:
		line_2d.points[1] = playerDirection * 40
	else:
		line_2d.points[1] = Vector2.ZERO
	playerDirection.y = -playerDirection.y
	playerAngle = rad_to_deg(playerDirection.angle())
	if playerAngle < 0:
		playerAngle = playerAngle + 360

func GetDirectionName() -> String:
	facingDirection = "Up"
	if playerAngle > 135 && playerAngle <= 225:
		facingDirection = "Left"
	elif playerAngle > 225 && playerAngle <= 315:
		facingDirection = "Down"
	elif playerAngle > 315 || playerAngle <= 45:
		facingDirection = "Right"
	return facingDirection


func _on_area_2d_body_area_entered(area: Area2D) -> void:
	var enteredNode = area.get_parent()
	if enteredNode == player:
		player.GetHit(attackDamage,global_position)
