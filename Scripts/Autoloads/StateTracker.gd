extends Node

# Flags
var pause_movement := false

# Emails / Messages / Inbox
var inbox: Array = [
	{
		"read": false,
		"from": "Mom",
		"subject": "Checking in",
		"message": "You okay sweety?"
	}
]

func add_message(from, subject, msg, read : bool = false):
	inbox.append({
		"read": read,
		"from": from,
		"subject": subject,
		"message": msg
	})

# Jobs
enum job_status {OPEN, COMPLETED, FAILED}

var jobs: Array = [
	{
		"difficulty": 0,
		"reward": 500,
		"client": "Mr. Johnson",
		"job_name": "Undisclosed CS",
		"description": "Mr. Johnson has a docket with requirements for a cybersecurity action. Discretion is required.",
		"status": job_status.OPEN
	}
]

func add_job(difficulty: int, reward, client, job_name, description, status = job_status.OPEN):
	inbox.append({
		"difficulty": difficulty,
		"reward": reward,
		"client": client,
		"job_name": job_name,
		"description": description,
		"status": status
	})

# Notes
var notes: String = ""

func set_notes(new_notes):
	notes = new_notes
