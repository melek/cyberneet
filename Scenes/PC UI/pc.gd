extends Control

# Called when the node enters the scene tree for the first time.

var sample_emails = [{
		"read": false,
		"date": 1,
		"from": "Mom",
		"subject": "Checking in",
		"message": "You okay sweety?"
	}, {
		"read": false,
		"date": 2,
		"from": "Mr. Johnson",
		"subject": "u r ded",
		"message": "Mess with me and get messed with.\n\nI suggest you get a last meal in before Sunday."
	}, ]
	
var sample_jobs = [{
		"difficulty": 0,
		"date": 1,
		"reward": 500,
		"client": "Mr. Johnson",
		"job_name": "Undisclosed CS",
		"description": "Mr. Johnson has a docket with requirements for a cybersecurity action. Discretion is required.",
		"status": StateTracker.job_status.OPEN
	}, {
		"difficulty": 2,
		"date": 2,
		"reward": 15500,
		"client": "UNKNOWN",
		"job_name": "Concierge Service",
		"description": "Professional involuntary retirement concierge. Full service required. Crypto only.",
		"status": StateTracker.job_status.OPEN
	} ]

func _ready():
	for e in sample_emails: StateTracker.add_email(e)
	load_inbox()	
	
	for j in sample_jobs: StateTracker.add_job(j)
	load_jobs()
	
func load_inbox():
	$Panel/Inbox/TextEdit.hide()
	var message_list =  $Panel/Inbox/Contacts
	
	# Clear the message list.
	for node in message_list.get_children(): node.queue_free()
	
	# Build the list.
	var new_email: Button
	for msg in StateTracker.inbox:
		new_email = create_email_button(msg)
		message_list.add_child(new_email)
	
func create_email_button(msg) -> Button:
	var new_button = Button.new()
	new_button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	new_button.text = msg.subject
	new_button.pressed.connect(show_email.bind(msg))
	return new_button	

func show_email(msg):
	var email_view = $Panel/Inbox/TextEdit
	email_view.show()
	email_view.text = "Day " + str(msg.date) \
		+ "\nFrom: " + msg.from \
		+ "\n-----\n\n" + msg.message 

# Jobs
func load_jobs():
	$Panel/Jobs/TextEdit.hide()
	var job_listings =  $Panel/Jobs/Listings
	
	# Clear the message list.
	for node in job_listings.get_children(): node.queue_free()
	
	# Build the list.
	var new_listing: HBoxContainer
	for job in StateTracker.jobs:
		new_listing = create_job_listing(job)
		job_listings.add_child(new_listing)
	
func create_job_listing(job) -> HBoxContainer:
	var new_job = HBoxContainer.new()
	new_job.focus_mode = Control.FOCUS_ALL
	
	# Difficulty
	var difficulty = Label.new()
	var diff_color : Color;
	if   job.difficulty <= 0: diff_color = Color.GREEN
	elif job.difficulty == 1: diff_color = Color.YELLOW
	elif job.difficulty == 2: diff_color = Color.ORANGE
	elif job.difficulty == 3: diff_color = Color.RED
	else 					: diff_color = Color.DARK_RED
	difficulty.add_theme_color_override("font_color", diff_color)
	difficulty.text = "▓"
	new_job.add_child(difficulty)
	
	# Job name / label
	var job_label = Label.new()
	job_label.text = job.client
	new_job.add_child(job_label)
	
	# Reward
	var reward = Label.new()
	if   job.reward < 1000: reward.text = "$"
	elif job.reward < 10000: reward.text = "$$"
	elif job.reward < 25000: reward.text = "$$$"
	else				   : reward.text = "$$$$"
	new_job.add_child(reward)	
	new_job.focus_entered.connect(show_job.bind(job))
	return new_job

func show_job(job):
	var listing_view = $Panel/Jobs/TextEdit
	listing_view.show()
	listing_view.text = "Day " + str(job.date) \
		+ "\nClient: " + job.client \
		+ "\nListing Name: " + job.job_name + " (" +  str(job.reward) + ")" \
		+ "\n-----\n\n" + job.description

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func hide_sections():
	$Panel/Inbox.hide()
	$Panel/Jobs.hide()
	$Panel/Notes.hide()

func _on_inbox_button_toggled(toggled_on):
	hide_sections()
	if(toggled_on):
		$Panel/Inbox.show()
	
func _on_jobs_button_toggled(toggled_on):
	hide_sections()
	if(toggled_on):
		$Panel/Jobs.show()

func _on_note_button_toggled(toggled_on):
	hide_sections()
	if(toggled_on):
		$Panel/Notes.show()

func _on_code_edit_text_changed():
	StateTracker.set_notes($Panel/Notes/CodeEdit.text)
