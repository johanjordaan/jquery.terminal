module.exports = (grunt) ->

  grunt.initConfig
    pkg : grunt.file.readJSON('package.json')
    uglify :
      options :
      #  banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
        preserveComments : 'some'
      
      build : 
        src : 'js/jquery.terminal-<%= pkg.version %>.js',
        dest: 'js/jquery.terminal-<%= pkg.version %>.min.js'

    coffee: 
      build:
        expand: true,
        cwd: './src',
        src: ['**/*.coffee'],
        dest: './',
        ext: '.js'
        extDot : 'last'

    shell:
      bower_json:
        command: 'sed -e "s/{{VER}}/<%= pkg.version %>/g" bower.in > bower.json'
      version_terminal:
        command: 'sed -e "s/{{VER}}/<%= pkg.version %>/g" -e "s/{{DATE}}/`date -uR`/g" js/jquery.terminal-src.js > js/jquery.terminal-<%= pkg.version %>.js'
      create_min_copy:  
        command: 'cp js/jquery.terminal-<%= pkg.version %>.min.js js/jquery.terminal-min.js'  
      terminal_jquery_json:
        command: 'sed -e "s/{{VER}}/<%= pkg.version %>/g" manifest > terminal.jquery.json'

    jasmine_node:
      options:
        forceExit: true
        match: '.'
        matchall: false
        extensions: 'js'
        specNameMatcher: 'spec'
        jUnit: 
          report: true
          savePath : "./build/reports/jasmine/"
          useDotNotation: true
          consolidate: true
      all: ['test/']
  
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-mocha-test')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-jasmine-node');

  grunt.registerTask('default', ['coffee','jasmine_node']);
  grunt.registerTask('release', ['default','shell:bower_json','shell:version_terminal','uglify','shell:create_min_copy','shell:terminal_jquery_json' ]);
  




