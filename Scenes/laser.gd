extends CharacterBody2D
var laserSpeed: int = 700
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(-(laserSpeed * sin(rotation)), (laserSpeed * cos(rotation))) * delta
