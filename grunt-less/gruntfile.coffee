module.exports = (grunt) ->
	grunt.initConfig
		watch:
			less:
				files:["less/**/*.less"]
				tasks:["less"]
		less:
			options:
				paths:"less"
			src:
				"expand":true,
				"cwd":"less",
				"src":"*.less",
				"dest":"less-build/",
				"ext":".css"
	grunt.loadNpmTasks('grunt-contrib-less')
	grunt.loadNpmTasks('grunt-contrib-watch')
	grunt.registerTask 'default', 'Gruntfile Running', ->
		# do some require job
		grunt.log.write('Running the grunt task')
		console.log "something"
		console.log "shit"

