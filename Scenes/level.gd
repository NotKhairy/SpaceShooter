extends Node2D
var meteor_scene: PackedScene = load("res://Scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://Scenes/laser.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_meteor_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	$Meteors.add_child(meteor)


func _on_player_laser(pos, rot) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
	laser.rotation = rot
