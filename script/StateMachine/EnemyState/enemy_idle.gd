extends State

var playerDetectionRadius = 100
@onready var polygon_2d: Polygon2D = $"../../Polygon2D"

func Enter():
	super.Enter()
	if character.showDebugVisual:
		CreatPolygonCircle()
	else:
		polygon_2d.polygon = PackedVector2Array()

func Exit():
	super.Exit()
	if character.showDebugVisual:
		polygon_2d.polygon = PackedVector2Array()


func Update():
	super.Update()
	character.UpdateAnimate()
	
	if character.global_position.distance_to(character.player.global_position) <= playerDetectionRadius:
		parentStateMachine.SwichTo("Move")


func CreatPolygonCircle():
	var points : PackedVector2Array
	
	for i in 36:
		var angle = deg_to_rad(i * 10)
		var pointsVector2D = Vector2(cos(angle) , sin(angle))
		pointsVector2D *= playerDetectionRadius
		points.append(pointsVector2D)
		
	polygon_2d.polygon = points
