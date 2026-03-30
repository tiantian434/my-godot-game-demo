extends Area2D

var player : BaseCharacter
var parent : enemyCharacter

func _ready() -> void:
	player = get_tree().root.get_node("ScenceNode/Level/Player")
	parent = get_parent()

func _physics_process(_delta: float) -> void:
	if monitoring == true:
		var bodies = get_overlapping_areas()
		for body in bodies:
			if body.get_parent() == player:
				player.GetHit(parent.attackDamage,global_position)
