module main

import os
import encoding.hex
import rand
import time

// Delete all file that where generated
fn (mut app App) delete_files() {
	
	for i, p in app.generated_files {
		
		if app.verbose {
			print('Removing file [${i + 1}/${app.file_count}]: ${p}')
		}
		
		if app.debug_mode {
			app.log.info('Removing file [${i + 1}/${app.file_count}]: ${p}')
		}

		os.rm(p) or {
			if app.verbose {
				println(' [ error ]')
			}
			app.log.error(err.str())
		}
		duration := time.Duration(app.interval_time) * time.millisecond
		time.sleep(duration)
		if app.verbose {
			println(' [ done ]')
		}
	}
}

fn (mut app App) create_files() {
	app.log.info('Creating ${app.file_count} files on folder ${app.path}')
	// Check if the folder exists
	if !os.exists(app.path) {
		os.mkdir_all(app.path) or { panic(err) }
		if app.verbose {
			println('Creating folder: ${app.path}')
		}
		if app.debug_mode {
			app.log.info('Creating folder: ${app.path}')
		}
	}

	if !app.pattern_name.starts_with('.') {
		app.pattern_name = '.' + app.pattern_name
	}

	for i := 1; i <= app.file_count; i++ {
		if app.pattern_random {
			app.pattern_name = generate_random_pattern()
		}

		file_path := '${app.path}/fgen_${generate_suid()}${app.pattern_name}'

		if app.verbose {
			print('Creating file [${i}/${app.file_count}]: ${file_path}')
		}
		mut f := os.create(file_path) or {
			if app.verbose {
				println(' [ error ]')
			}
			println(err)
			return
		}

		app.generated_files << file_path
		duration := time.Duration(app.interval_time) * time.millisecond
		time.sleep(duration)
		if app.verbose {
			println(' [ done ]')
		}
		f.close()
	}
}

fn generate_suid() string {
	length := 8 // for a 128-bit (16-byte) SUID
	random_bytes := rand.bytes(length) or { panic(err) }

	return hex.encode(random_bytes)
}

fn generate_random_pattern() string {
	list := ['.xxx', '.locky', '.lck', '..txt', '.cancer', '.dale', '.funny', '.jager', '.lion',
		'.otr', '.ragnar']
	rand_index := rand.intn(list.len) or { 0 }

	return list[rand_index]
}
