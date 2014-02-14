/*jshint camelcase: false*/
// Generated on 2013-08-01 using generator-chrome-extension 0.2.3

module.exports = function (grunt) {
  'use strict';

  // load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  // configurable paths
  var config = {
    app: 'app',
    dist: 'dist',
    tmp: 'tmp',
    resources: 'resources'
  };

  grunt.initConfig({
    config: config,
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '<%= config.dist %>/*',
            '<%= config.tmp %>/*'
          ]
        }]
      }
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc'
      },
      files: '<%= config.app %>/js/*.js'
    },
    copy: {
      appLinux: {
        files: [{
          expand: true,
          cwd: '<%= config.app %>',
          dest: '<%= config.dist %>/app.nw',
          src: '**'
        }]
      },
      appMacos: {
        files: [{
          expand: true,
          cwd: '<%= config.app %>',
          dest: '<%= config.dist %>/node-webkit.app/Contents/Resources/app.nw',
          src: '**'
        },
          {
            expand: true,
            cwd: '<%= config.resources %>/mac-files/',
            dest: '<%= config.dist %>/node-webkit.app/Contents/',
            filter: 'isFile',
            src: '*.plist'
          },
          {
            expand: true,
            cwd: '<%= config.resources %>/mac-files/',
            dest: '<%= config.dist %>/node-webkit.app/Contents/Resources/',
            filter: 'isFile',
            src: '*.icns'
          }]
      },
      webkit: {
        files: [{
          expand: true,
          cwd: '<%=config.resources %>/node-webkit/MacOS',
          dest: '<%= config.dist %>/',
          src: '**'
        }]
      },
      copyWinToTmp: {
        files: [{
          expand: true,
          cwd: '<%= config.resources %>/node-webkit/Windows/',
          dest: '<%= config.tmp %>/',
          src: '**'
        }]
      }
    },
    compress: {
      appToTmp: {
        options: {
          archive: '<%= config.tmp %>/app.zip'
        },
        files: [
          {
            expand: true,
            cwd:'<%= config.app %>',
            src: ['**']
          }
        ]
      },
      finalWindowsApp: {
        options: {
          archive: '<%= config.dist %>/kr2.zip'
        },
        files: [
          {
            expand: true,
            cwd:'<%= config.tmp %>',
            src: ['**']
          }
        ]
      }
    },
    rename: {
      app: {
        files: [
          {
            src: '<%= config.dist %>/node-webkit.app',
            dest: '<%= config.dist %>/kr2.app'
          }
        ]
      },
      zipToApp: {
        files: [
          {
            src: '<%= config.tmp %>/app.zip',
            dest: '<%= config.tmp %>/app.nw'
          }
        ]
      }
    }
  });

  grunt.registerTask('chmod', 'Add lost Permissions.', function () {
    var fs = require('fs');
    fs.chmodSync('dist/kr2.app/Contents/Frameworks/node-webkit Helper EH.app/Contents/MacOS/node-webkit Helper EH', '555');
    fs.chmodSync('dist/kr2.app/Contents/Frameworks/node-webkit Helper NP.app/Contents/MacOS/node-webkit Helper NP', '555');
    fs.chmodSync('dist/kr2.app/Contents/Frameworks/node-webkit Helper.app/Contents/MacOS/node-webkit Helper', '555');
    fs.chmodSync('dist/kr2.app/Contents/MacOS/node-webkit', '555');
  });

  grunt.registerTask('createLinuxApp', 'Create linux distribution.', function () {
    var fs = require('fs');
    var childProcess = require('child_process');
    var exec = childProcess.exec;
    exec('mkdir dist; cp resources/node-webkit/linux_ia64/nw.pak dist/ && cp resources/node-webkit/linux_ia64/nw dist/node-webkit && cp resources/linux/qq dist/qq && chmod a+x dist/qq; touch dist/ready', function (error, stdout, stderr) {
      console.log(stderr, stdout, error);
    });
    while (!fs.existsSync('dist/ready')) {}
  });

  grunt.registerTask('createWindowsApp', 'Create windows distribution.', function () {
    var fs = require('fs');
    var childProcess = require('child_process');
    var exec = childProcess.exec;
    exec('copy /b tmp\\nw.exe+tmp\\app.nw tmp\\kr2.exe && del tmp\\app.nw tmp\\nw.exe && echo.>tmp\\ready', function (error, stdout, stderr) {
      console.log(stderr, stdout, error);
    });
    while (!fs.existsSync('tmp/ready')) {}
  });

  grunt.registerTask('setVersion', 'Set version to all needed files', function(version){
    var config = grunt.config.get(['config']);
    var appPath = config.app;
    var resourcesPath = config.resources;
    var mainPackageJSON = grunt.file.readJSON('package.json');
    var appPackageJSON = grunt.file.readJSON(appPath + '/package.json');
    var infoPlistTmp = grunt.file.read(resourcesPath + '/mac-files/Info.plist.tmp', {encoding: 'UTF8'});
    var infoPlist = grunt.template.process(infoPlistTmp, {data: {version: version}});
    mainPackageJSON.version = version;
    appPackageJSON.version = version;
    grunt.file.write('package.json', JSON.stringify(mainPackageJSON, null, 2), {encoding: 'UTF8'});
    grunt.file.write(appPath + '/package.json', JSON.stringify(appPackageJSON, null, 2), {encoding: 'UTF8'});
    grunt.file.write(resourcesPath + '/mac-files/Info.plist', infoPlist, {encoding: 'UTF8'});
  });

  grunt.registerTask('dist-linux', [
    'jshint',
    'clean:dist',
    'copy:appLinux',
    'createLinuxApp'
  ]);

  grunt.registerTask('dist-win', [
    'jshint',
    'clean:dist',
    'copy:copyWinToTmp',
    'compress:appToTmp',
    'rename:zipToApp',
    'createWindowsApp',
    'compress:finalWindowsApp'
  ]);

  grunt.registerTask('dist-mac', [
    'jshint',
    'clean:dist',
    'copy:webkit',
    'copy:appMacos',
    'rename:app',
    'chmod'
  ]);

  grunt.registerTask('check', [
    'jshint'
  ]);

};