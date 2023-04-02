extends CharacterBody2D


const SPEED = 125.0
const JUMP_VELOCITY = -250

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jabcount = 0


func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not $AnimationPlayer.is_playing():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("shift") and is_on_floor() and not $AnimationPlayer.is_playing() and jabcount != 2:
		$AnimationPlayer.play("Jab")
	if Input.is_action_just_released("shift"):
		jabcount = 0

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction and not $AnimationPlayer.is_playing():
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Jab":
		jabcount += 1
