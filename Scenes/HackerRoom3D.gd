extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(e):
	if e is InputEventKey:
		if e.keycode == KEY_TAB and e.pressed:
			$Control.visible = !$Control.visible
			StateTracker.pause_movement = $Control.visible
