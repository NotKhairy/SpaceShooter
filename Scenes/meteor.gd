extends Area2D
var rng:= RandomNumberGenerator.new()
var speed = rng.randi_range(7, 12)
var arr = ["res://PNG/Meteors/meteorBrown_big1.png","res://PNG/Meteors/meteorBrown_big2.png","res://PNG/Meteors/meteorBrown_big3.png", "res://PNG/Meteors/meteorBrown_big4.png", "res://PNG/Meteors/meteorBrown_med1.png", "res://PNG/Meteors/meteorBrown_med3.png", "res://PNG/Meteors/meteorBrown_small1.png", "res://PNG/Meteors/meteorBrown_small2.png", "res://PNG/Meteors/meteorBrown_tiny1.png", "res://PNG/Meteors/meteorBrown_tiny2.png", "res://PNG/Meteors/meteorGrey_big1.png", "res://PNG/Meteors/meteorGrey_big2.png", "res://PNG/Meteors/meteorGrey_big3.png", "res://PNG/Meteors/meteorGrey_big4.png", "res://PNG/Meteors/meteorGrey_med1.png", "res://PNG/Meteors/meteorGrey_med2.png", "res://PNG/Meteors/meteorGrey_small1.png", "res://PNG/Meteors/meteorGrey_small2.png", "res://PNG/Meteors/meteorGrey_tiny1.png", "res://PNG/Meteors/meteorGrey_tiny2.png"]
var rotation_speed: int
signal collision

func _ready() -> void:
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	var random_texture_index = rng.randi_range(0, arr.size()-1)
	position = Vector2(random_x,random_y)
	rotation_speed = rng.randi_range(40,100)
	$MeteorPicture.set_texture(load(arr[random_texture_index]))
	

func _process (delta):
	position += Vector2(0,10) * speed * delta
	rotation_degrees += rotation_speed * delta

func _on_body_entered(_body: Node2D) -> void:
	collision.emit()
