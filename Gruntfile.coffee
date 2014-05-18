module.exports = (grunt) ->

    require('load-grunt-tasks') grunt

    grunt.initConfig
        pkg: 
            grunt.file.readJSON('package.json')

        nodewebkit:
            options:
                build_dir: 'dist'
                linux32: true
                linux64: true
                mac: true
                win: true
            src: 'app/**'

        coffee:
            compile:
                expand: true
                cwd: 'src/scripts'
                src: '**/*.coffee'
                dest: 'app/scripts'
                ext: '.js'

        less:
            src:
                expand: true
                cwd: 'src/style'
                src: '**/*.less'
                dest: 'app/style'
                ext: '.css'

        copy:
            index:
                src: 'src/index.html'
                dest: 'app/index.html'
            package:
                src: 'src/package.json'
                dest: 'app/package.json'
            partials:
                expand: true
                cwd: 'src/partials'
                src: '**/*.html'
                dest: 'app/partials'


        exec:
            runNW:
                cwd: './node_modules/nodewebkit/bin'
                cmd: ->
                    if process.platform is 'win32'
                        'start /b nodewebkit ../../../app'
                    else
                        'nodewebkit ../../../app &'

        watch:
            coffee:
                files: 'src/scripts/**/*.coffee'
                tasks: 'coffee'
            less:
                files: 'src/style/**/*.less'
                tasks: 'less'

        clean:
            build:
                src: [
                    "app/index.html"
                    "app/package.json"
                    "app/partials"
                    "app/scripts"
                    "app/style"
                ]

    grunt.event.on 'coffee.error', (msg) ->
        grunt.log.write msg

    grunt.registerTask 'deploy', ['build', 'nodewebkit']
    grunt.registerTask 'build', ['copy', 'less', 'coffee']
    grunt.registerTask 'run', ['build', 'exec:runNW', 'watch']
    grunt.registerTask 'default', ['run']