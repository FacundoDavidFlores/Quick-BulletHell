extends Sprite2D
class_name Bullet
#-------------------------------------------------------------------------------
var size: Vector2 = Vector2(2.0, 4.0)
#-------------------------------------------------------------------------------
var vel: float = 0.0
var dir: float = 0.0
var velX: float
var velY: float
#-------------------------------------------------------------------------------
#func _draw():
	#draw_rect(Rect2(-size.x, -size.y, size.x*2.0, size.y*2.0), Color.RED)
#-------------------------------------------------------------------------------
