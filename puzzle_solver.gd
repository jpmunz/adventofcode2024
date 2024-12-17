extends Area2D

class_name PuzzleSolver

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#var f = FileAccess.open("res://puzzle_input/full_1.txt", FileAccess.READ)
	#solve(f.get_as_text())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func solve(input: String) -> void:
	var list3Label = $Terminal/List3 as Label
	list3Label.text = ""

	$Terminal.set_message("Sorting inputs")

	var lines = input.split("\n")
	var list1 = [];
	var list2 = [];
	
	for line in lines:
		if not line:
			continue
		var items = line.split("   ")
		list1.push_back(int(items[0]))
		list2.push_back(int(items[1]))
	
	var list1Label = $Terminal/List1 as Label
	list1Label.text = "\n".join(list1)
	var list2Label = $Terminal/List2 as Label
	list2Label.text = "\n".join(list2)
	
	list1.sort()
	list2.sort()
	
	await get_tree().create_timer(5).timeout
	list1Label.text = ""
	list2Label.text = ""
	$Terminal.set_message("Summing differences")
	await get_tree().create_timer(1).timeout

	var wait_time = .1
	var speed_up = .001
	var total_diff = 0
	for i in range(len(list1)):
		total_diff += abs(list1[i] - list2[i])
		if wait_time >= .0001:
			list3Label.text = str(total_diff)
			await get_tree().create_timer(wait_time).timeout
			wait_time -= speed_up
			
	list3Label.text = str(total_diff)
	$Terminal.set_done()

func _on_sorting_animation_timer_timeout() -> void:
	var list1Label = $Terminal/List1 as Label
	var t1 = list1Label.text
	var items1 = t1.split("\n")
	var last1 = items1[0]
	items1.remove_at(0)
	items1.push_back(last1)
	list1Label.text = "\n".join(items1)

	var list2Label = $Terminal/List2 as Label
	var t2 = list2Label.text
	var items2 = t2.split("\n")
	var last2 = items2[0]
	items2.remove_at(0)
	items2.push_back(last2)
	list2Label.text = "\n".join(items2)
