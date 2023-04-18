extends KinematicBody2D

export var speed = 10
export var health = 1
var velocity = Vector2.ZERO
var move_direction = -1

onready var boss = $Boss
onready var player = $Player
onready var boss_sprite = $BOSS/AnimatedSprite
onready var boss_collision_area = $Boss/BossCollisionArea

func _physics_process(delta: float) -> void:
	velocity.x = speed * move_direction
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body: Node) -> void:
	if body == boss:
		boss_sprite.play("attack")
		boss.attack()
		# aqui você pode adicionar o que deseja que aconteça depois que o boss atacar o player
