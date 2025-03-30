extends Area2D
var rng:= RandomNumberGenerator.new()
var speed = rng.randi_range(7, 12)
var health
var arr = [
	"res://PNG/Meteors/meteorBrown_big1.png","res://PNG/Meteors/meteorBrown_big2.png","res://PNG/Meteors/meteorBrown_big3.png", 
	"res://PNG/Meteors/meteorBrown_big4.png","res://PNG/Meteors/meteorGrey_big1.png","res://PNG/Meteors/meteorGrey_big2.png", 
	"res://PNG/Meteors/meteorGrey_big3.png", "res://PNG/Meteors/meteorGrey_big4.png",
	"res://PNG/Meteors/meteorBrown_med1.png", "res://PNG/Meteors/meteorBrown_med3.png", "res://PNG/Meteors/meteorGrey_med1.png",
	"res://PNG/Meteors/meteorGrey_med2.png",
	"res://PNG/Meteors/meteorBrown_small1.png", "res://PNG/Meteors/meteorBrown_small2.png",  
	"res://PNG/Meteors/meteorGrey_small1.png", "res://PNG/Meteors/meteorGrey_small2.png", 
	"res://PNG/Meteors/meteorGrey_tiny1.png", "res://PNG/Meteors/meteorGrey_tiny2.png", "res://PNG/Meteors/meteorBrown_tiny1.png",  
	"res://PNG/Meteors/meteorBrown_tiny2.png"]
var arr2 = [
	
]
var rotation_speed: int
@export var recalculate_geometry : bool :
	set(_value):
		_create_polygon2d_nodes_from_sprite2d()

signal collision

func _ready() -> void:
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	var random_texture_index = rng.randi_range(0, arr.size()-1)
	position = Vector2(random_x,random_y)
	rotation_speed = rng.randi_range(40,100)
	$MeteorPicture.set_texture(load(arr[random_texture_index]))
	_create_polygon2d_nodes_from_sprite2d()
	if (random_texture_index >= 0 && random_texture_index <8):
		health = 7
	elif(random_texture_index >= 8 && random_texture_index <12) :
		health = 5
	elif(random_texture_index >= 12 && random_texture_index <16):
		health = 3
	elif(random_texture_index >= 16 && random_texture_index <20):
		health = 1
	

func _process (delta):
	position += Vector2(0,10) * speed * delta
	rotation_degrees += rotation_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player") :
		collision.emit()
	else :
		health -= 1
		if(health <= 0) :
			queue_free()
func _create_polygon2d_nodes_from_sprite2d():
	# Assume Sprite2D with texture and StaticBody2D exist
	var sprite = $MeteorPicture
	var static_body = self

	# Destroy Existing Collision Polygons
	for node in static_body.find_children("*", "CollisionPolygon2D"):
		node.queue_free()

	# Generate Bitmap from Sprite2D
	var image = sprite.texture.get_image()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(image)

	# Convert Bitmap to Polygons
	var polys = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, image.get_size()), 0.0)

	# Create CollisionPolygon2D Nodes from Polygons
	for poly in polys:
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.polygon = poly
		static_body.add_child(collision_polygon)
		collision_polygon.set_owner(get_tree().get_edited_scene_root())
		collision_polygon.position -= sprite.texture.get_size() / 2
