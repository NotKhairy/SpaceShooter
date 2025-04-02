extends Node2D
var meteor_scene: PackedScene = load("res://Scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://Scenes/laser.tscn")
@export var currDiff = Global.difficulty.EASY
signal UIStart()
signal UIUpdate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (currDiff == Global.difficulty.EASY):
		Global.health = 5
	elif (currDiff == Global.difficulty.MEDIUM):
		Global.health = 3
	else:
		Global.health = 1
	UIStart.emit()
	$Player.position = get_viewport().get_visible_rect().size /2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_meteor_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	$Meteors.add_child(meteor)
	meteor.connect('collision', on_meteor_collision)
	
func on_meteor_collision(body: Node2D) -> void:
	if (body.name == "Player") :
		Global.health -= 1
		UIUpdate.emit()
		if Global.health <=0:
			get_tree().paused = true
			var game_over_ui = load("res://Scenes/game_over.tscn").instantiate()
			get_tree().root.add_child(game_over_ui)
	else :
		Global.score += 1
		UIUpdate.emit()


func _on_player_laser(pos, rot) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
	laser.rotation = rot - PI
