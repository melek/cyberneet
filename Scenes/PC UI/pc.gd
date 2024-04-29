extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/Inbox/Contacts/RichTextLabel.queue_free()
	load_messages()
	
	
func load_messages():
	var contact_list =  $Panel/Inbox/Contacts
	var contact_template : Button
	
	for msg in StateTracker.inbox:
		contact_template = Button.new()
		contact_template.alignment = HORIZONTAL_ALIGNMENT_LEFT
		contact_template.text = msg.subject
		contact_list.add_child(contact_template)

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
