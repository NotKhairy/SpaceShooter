extends CanvasLayer
var life_scene: PackedScene = load("res://Scenes/life.tscn")
var lives: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_ui_start(diff: Variant) -> void:
	if diff == 0 :
		for i in range(5) :
			var life = life_scene.instantiate()
			get_child(1).get_child(0).add_child(life)
		lives = 5
	elif diff == 1 :
		for i in range(3) :
			print(get_child(1))
			var life = life_scene.instantiate()
			get_child(1).get_child(0).add_child(life)
		lives = 3
	elif diff == 2 :
		var life = life_scene.instantiate()
		get_child(1).get_child(0).add_child(life)
		lives = 1


func _on_level_ui_update(score: Variant, health: Variant) -> void:
	if (health != lives):
		var node = get_child(1).get_child(0).get_child(lives-1)
		node.modulate = Color(node.modulate.r, node.modulate.g, node.modulate.b, 0.7)
		lives = lives - 1
	$MarginContainer/VBoxContainer/score.text = str(score)
