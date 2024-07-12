module main

import flag
import os

const version = 0.1

fn (mut app App) parse_args(args []string) ! {
	mut fp := flag.new_flag_parser(os.args)

	fp.limit_free_args(1, 7)! // comment this, if you expect arbitrary texts after the options
	fp.skip_executable()

	app.file_count = fp.int('file', `f`, 1, '')
	app.interval_time = fp.int('interval', `i`, 0, '')
	app.delete_file = fp.bool('delete', `d`, false, '')
	app.verbose = fp.bool('verbose', `v`, false, '')
	app.pattern_name = fp.string('pattern', `p`, '.fgen', '')
	app.pattern_random = fp.bool('random', `r`, false, '')
	app.debug_mode = fp.bool('debug', `u`, false, '')

	fp.finalize() or {
		usage()
		return err
	}

	app.path = fp.args.first()
}

fn (app App) print_flags() {
	println('File count: ${app.file_count}')
	println('Pattern name: ${app.pattern_name}')
	println('Random: ${app.pattern_random}')
	println('Interval: ${app.interval_time}')
	println('Delete: ${app.delete_file}')
	println('Verbose: ${app.verbose}')
	println('Debug Mode: ${app.debug_mode}')
	println('Path: ${app.path}')
}

fn usage() {
	println('fgen version ${version} is a command line tool for generating files. ')
	println('')
	println('Usage:')
	println('  fgen [command] [params] path')
	println('')
	println('Examples:')
	println('   fgen -f 1000 files/               generate 1000 dummy file with .fgen extension')
	println('                                     in the folder files.')
	println('   fgen -f 1000 -p locky .           use .locky instate of .fgen')
	println('   fgen -f 500 -p locky -i 500 .     add an interval while generating adn/or deleting files.')

	println('')
	println('Commands:')
	println('  -f, --file <num>                   create num of dummy files.')
	println('  -p, --pattern <name>               use pattern as extension instate of .fgen.')
	println('  -r, --random                       generate randomly know pattern')
	println('  -i, --interval <ms>                interval between file creation / deletion.')
	println('  -v, --verbose                      show verbose information.')
	println('  -d                                 delete files after created.')
	println('')
}
