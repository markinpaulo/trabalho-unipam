extends KinematicBody2D

var is_moving_left = true

var gravity =  10 
var velocity = Vector2(0, 0)

var speed = 10

func _ready():
	$AnimatedSprite.play("idle")

func _process(_delta):
	if $AnimationPlayer.current_animation == "attack":
		
		return	

	move_character()
		
func move_character():
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	

func hit():
	$AttackDetector.monitoring = true
	$hitFx.play()

func end_of_hit():
	$AttackDetector.monitoring = false
	
func start_walk():
	$AnimationPlayer.play("idle")

func _on_PlayerDetector_body_entered(_body):
	$AnimationPlayer.play("attack")
	
func _on_AttackDetector_body_exited(_body):
	$AnimationPlayer.play("idle")
   

