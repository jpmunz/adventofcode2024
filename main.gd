extends Node

var loadedLevel: Node

var playerPosition = Vector2(140, 1294)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$World/Player.position = playerPosition

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_entered_door(door: Door) -> void:
	print("on player entered door")
	if door:
		print("there was a door")
		if door.level:
			print("there was a level")
			playerPosition = $World/Player.position
			$World/LevelSelect.hide()
			loadedLevel = door.level.instantiate()
			$World.add_child(loadedLevel)
			$World/Player.position = door.startingPosition
		elif loadedLevel:
			print("there was no level")
			loadedLevel.hide()
			loadedLevel.queue_free()
			$World/Player.position = playerPosition
			$World/LevelSelect.show()


func _on_player_dropped(carrying: PuzzleInput, dropped: PuzzleSolver) -> void:
	var input = carrying.loadInput()
	dropped.solve(input)
