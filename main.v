module main

import os
import log

struct App {
mut:
	file_count      int
	pattern_name    string
	pattern_random  bool
	interval_time   int
	delete_file     bool
	verbose         bool
	debug_mode		bool
	path            string
	generated_files []string
	log             log.Log
}

fn main() {
	mut app := App{}

	app.parse_args(os.args) or {
		app.log.info(err.str())
		exit(1)
	}

	if app.debug_mode {
		app.log.set_level(.info)
		app.log.set_full_logpath('./fgen.log')
		app.log.info('App started...')
	} else {
		app.log.set_level(.error)
	}

	app.log.info('parse_args: ${os.args}')
	
	app.create_files()
	if app.delete_file {
		app.delete_files()
	}
}
