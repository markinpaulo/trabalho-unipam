extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 500
var gravity = 1200
var jump_force = -720
var is_grounded
var is_attacking = false 

onready var anim_player = $anim
onready var raycasts = $raycasts
onready var attack_area = $AttackCollider

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	_get_input()

	velocity = move_and_slide(velocity)

	is_grounded = _check_is_ground()

	_set_animation()

func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.3)

	if move_direction != 0:
		$texture.scale.x = move_direction

	if Input.is_action_pressed("personagem_attack") and !is_attacking:  
		is_attacking = true 
		anim_player.play("attack")  

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_grounded:
		velocity.y = jump_force / 2

	if event.is_action_released("personagem_attack"):
		is_attacking = false  

	
func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func _set_animation():
	var anim = "idle"

	if !is_grounded:
		anim = "jump"

	elif velocity.x != 0:
		anim = "run"

	if is_attacking:
		if anim_player.current_animation != "attack":  
			anim_player.play("attack")  
	else:
		if anim_player.current_animation != anim:  
			anim_player.play(anim)  # 

	# reinicia a variável is_attacking para false quando a animação de ataque terminar
	if anim_player.current_animation == "personagem_attack" and anim_player.position == anim_player.get_animation_length("attack"):
		is_attacking = true
