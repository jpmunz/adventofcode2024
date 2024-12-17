extends Sprite2D

var current_pattern = 0
var dot_patterns = [" . . .", " .", " . ."]
var message = ""

func _ready() -> void:
	self.message = "Awaiting input"
	

func set_done() -> void:
	$Timer.stop()
	$Message.text = "Solved!"
	
func set_message(message: String) -> void:
	if $Timer.is_stopped():
		$Timer.start()
	self.message = message

func _on_timer_timeout() -> void:
	current_pattern = (current_pattern + 1) % len(dot_patterns)
	$Message.text = message + dot_patterns[current_pattern]
