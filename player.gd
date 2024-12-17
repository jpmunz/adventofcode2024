extends Area2D

signal enteredDoor
signal dropped


@export var speed = 400 # How fast the player will move (pixels/sec).
@export var carryingOffset = -50

var inFrontOf: Area2D
var carrying: Area2D
var pauseInteraction = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		pauseInteraction = false
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		pauseInteraction = false
	if Input.is_action_pressed("interact") and inFrontOf:
		pauseInteraction = true
		interact()
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	if carrying:
		carrying.position.x = position.x
		carrying.position.y = position.y + carryingOffset

func interact() -> void:
	var item = inFrontOf
	inFrontOf = null
	
	print("interacting")
	if item is Door:
		print("item is door")
		enteredDoor.emit(item)
	elif item.is_in_group("carryable"):
		item.get_node("CollisionShape2D").set_deferred("disabled", true)
		carrying = item
	elif item.is_in_group("dropable") and carrying:
		dropped.emit(carrying, item)
		carrying = null

func _on_area_entered(area: Area2D) -> void:
	if not pauseInteraction:
		inFrontOf = area

func _on_area_exited(area: Area2D) -> void:
	inFrontOf = null
