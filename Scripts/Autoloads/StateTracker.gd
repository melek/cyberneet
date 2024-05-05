extends Node

# Flags
var pause_movement := false

# Emails / Messages / Inbox
var inbox: Array[Dictionary] = []

func add_email(new_email: Dictionary):
	inbox.push_front(new_email)
	
# Jobs
enum job_status {OPEN, COMPLETED, FAILED}

var jobs: Array[Dictionary] = []

func add_job(new_job : Dictionary):
	jobs.push_front(new_job)

# Notes
var notes: String = ""

func set_notes(new_notes):
	notes = new_notes
