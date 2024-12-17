extends Area2D

class_name PuzzleInput


@export var input: String


func loadInput() -> String:
	var f = FileAccess.open(input, FileAccess.READ)
	var content = f.get_as_text()
	return content
