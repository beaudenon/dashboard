Delayed::Worker.backend = :active_record
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 30
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 30.minutes
