@tool
extends Sprite2D

@export var randomRegions : Array[Rect2]
var seedNumber : int

func _ready() -> void:
	updateRandomRegions()

func updateRandomRegions():
	if randomRegions:
		seedNumber = int(global_position.x + global_position.y)
		seed(seedNumber)
		var randomIdex = randi_range(0,randomRegions.size() - 1)
		region_rect = randomRegions[randomIdex]

func _enter_tree() -> void:
	set_notify_transform(true)

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		if Engine.is_editor_hint():
			updateRandomRegions()
