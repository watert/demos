module.exports = (grunt) ->
	grunt.initConfig
		# "less":grunt.file.readJSON('grunt-less-config.json')
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
				"ext":".css"
	grunt.loadNpmTasks('grunt-contrib-less')
	grunt.loadNpmTasks('grunt-contrib-watch')
	grunt.registerTask 'default', 'Try Logging', ->
		grunt.log.write('Running the default task')
