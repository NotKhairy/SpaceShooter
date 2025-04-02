extends CanvasLayer
var life_scene: PackedScene = load("res://Scenes/life.tscn")
var lifeIndex: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_ui_start() -> void:
	for i in range(Global.health) :
		var life = life_scene.instantiate()
		get_child(1).get_child(0).add_child(life)
	lifeIndex = Global.health -1
	$MarginContainer/VBoxContainer/score.text = str(Global.score)

func _on_level_ui_update() -> void:
	print(Global.health)
	print(lifeIndex)
	print("\n----------------------------------------\n")
	if (Global.health-1 != lifeIndex):
		print("nigga")
		print(Global.health)
		print(lifeIndex)
		var node = get_child(1).get_child(0).get_child(lifeIndex)
		node.modulate = Color(node.modulate.r, node.modulate.g, node.modulate.b, 0.7)
		lifeIndex -= 1
	$MarginContainer/VBoxContainer/score.text = str(Global.score)
