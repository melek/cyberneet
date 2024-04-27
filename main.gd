extends Control

# Resources
var day  : int
var cash : int
var actions : int

# Flags
var in_action : bool = false

# Signals
signal update_money

# Called when the node enters the scene tree for the first time.
func _ready():
	day = 1
	actions = 9
	update_cash(100)
	update_hud()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func get_time_of_day():
	if   actions >= 7: return "Morning"
	elif actions >= 4: return "Afternoon"
	else:              return "Evening"
	
func update_cash(n: int):
	cash = cash + n
	emit_signal("update_money", cash)
	$Resources/Money.text = "Money: " + str(cash)

func start_action(cost):
	if actions >= cost: 
		actions -= cost
		in_action = true	
	
func complete_action():
	in_action = false
	if(actions <= 0): end_day()
	update_hud()
		
func end_day():
	day += 1
	actions = 9

func update_hud():
	$Resources/Time.text = "Day " + str(day) + ": " + get_time_of_day()
	$Resources/Actions.text = "Actions Left: " + str(actions)

func _on_get_money_pressed():
	update_cash(5)

func _on_skip_pressed():
	start_action(1)
	complete_action()
