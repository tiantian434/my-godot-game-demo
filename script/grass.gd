extends Area2D
class_name Grass
var skewTween : Tween
var skewTweenBack : Tween

var scaleTween : Tween
var startScale = Vector2(1.0 , 1.0)
var endScale = Vector2(1.0 , 0.5)

@onready var sprite_2d_back: Sprite2D = $Sprite2D_back
@onready var sprite_2d: Sprite2D = $Sprite2D
const GRASS_CUT_VFX = preload("uid://c0ls1a7h7y2un")
const COIN = preload("uid://bq3tfqnt4j2ov")

func _ready() -> void:
	
	var startSkew = deg_to_rad(randf_range(-20,20))
	var endSkew = -startSkew
	
	skewTween = get_tree().create_tween().set_loops()
	skewTween.tween_property(sprite_2d,"skew",endSkew,1.5).from(startSkew)
	skewTween.tween_property(sprite_2d,"skew",startSkew,1.5).from(endSkew)
	skewTween.set_ease(Tween.EASE_OUT)
	skewTween.set_speed_scale(randf_range(0.5,1.5))
	
	var startSkewBack = endSkew * 0.5
	var endSkewBack = -startSkewBack
	
	skewTweenBack = get_tree().create_tween().set_loops()
	skewTweenBack.tween_property(sprite_2d_back,"skew",endSkewBack,1.5).from(startSkewBack)
	skewTweenBack.tween_property(sprite_2d_back,"skew",startSkewBack,1.5).from(endSkewBack)
	skewTweenBack.set_ease(Tween.EASE_OUT)


func _on_body_entered(_body: Node2D) -> void:
	creatNewTween(endScale,0.1)


func _on_body_exited(_body: Node2D) -> void:
	creatNewTween(startScale,0.5)

func creatNewTween(targetValue : Vector2 , duration : float):
	if scaleTween:
		scaleTween.kill()
		
	scaleTween = get_tree().create_tween()
	scaleTween.tween_property(sprite_2d,"scale",targetValue,duration)
	scaleTween.set_ease(Tween.EASE_OUT)

func GetCut():
	if skewTween:
		skewTween.kill()
	if scaleTween:
		scaleTween.kill()
	if skewTweenBack:
		skewTweenBack.kill()
	var grassCutVFXnode = GRASS_CUT_VFX.instantiate() as Node2D
	grassCutVFXnode.global_position = global_position
	get_parent().add_child(grassCutVFXnode)
	SpawnCoin()
	queue_free()
func _exit_tree() -> void:
	if skewTween:
		skewTween.kill()
	if scaleTween:
		scaleTween.kill()
	if skewTweenBack:
		skewTweenBack.kill()

func SpawnCoin():
	if randi() % 2 == 0:
		return
	var newCoin = COIN.instantiate() as Node2D
	newCoin.global_position = global_position
	get_tree().root.call_deferred("add_child",newCoin)
