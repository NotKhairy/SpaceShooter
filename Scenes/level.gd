extends Node2D
var meteor_scene: PackedScene = load("res://Scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://Scenes/laser.tscn")
var health: int = 5
var score: int = 0
enum difficulty { EASY, MEDIUM, HARD }

signal UIStart(difficulty)
signal gameOver()
signal UIUpdate(score, health)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UIStart.emit(difficulty.EASY)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_meteor_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	$Meteors.add_child(meteor)
	meteor.connect('collision', on_meteor_collision)
	
func on_meteor_collision() -> void:
	health -= 1
	UIUpdate.emit(score, health)
	if health <=0:
		gameOver.emit()


func _on_player_laser(pos, rot) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
	laser.rotation = rot
