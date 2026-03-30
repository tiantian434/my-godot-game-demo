extends Area2D
const COIN_VALUE = 1
const HEALTH_VALUE = 10
var UpWardMovementTween : Tween
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var targetPlayer : Node2D
var movingDirection : Vector2
const SPEED = 350

func _ready():
	UpWardMovementTween = get_tree().create_tween()
	UpWardMovementTween.tween_property(self,"global_position",global_position + Vector2(0,-15),0.1)
	UpWardMovementTween.tween_property(self,"global_position",global_position,0.1)
	UpWardMovementTween.tween_property(self,"global_position",global_position + Vector2(0,-6),0.05)
	UpWardMovementTween.tween_property(self,"global_position",global_position,0.05)
	
	monitoring = false
	await get_tree().create_timer(0.3).timeout
	monitoring = true



func _on_area_entered(area: Area2D) -> void:
	var player = area.get_parent() as PlayerCharacter
	if player:
		player.collectedCoin(HEALTH_VALUE,COIN_VALUE)
	
	animated_sprite_2d.play("Collected")
	set_deferred("monitoring",false)
	await get_tree().create_timer(0.5).timeout
	queue_free()
	


func _on_area_2d_wide_range_area_entered(area: Area2D) -> void:
	var player = area.get_parent() as PlayerCharacter
	if player:
		targetPlayer = player
func _physics_process(delta: float) -> void:
	if targetPlayer && monitoring == true:
		movingDirection = targetPlayer.global_position - global_position
		movingDirection = movingDirection.normalized()
		global_position = global_position + (movingDirection * delta * SPEED)
