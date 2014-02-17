var temp = require('temp');

var Runner = (function () {
  var my = {};
  var filePath = '';

  function runFile() {
    return "kidscode.rb";
  }

  my.running = false;
  my.process = null;

  my.run = function (code) {
    my.saveCode(runFile(), code);
    my.process = cp.spawn('ruby', [filePath]);
    my.running = true;
    my.process.stderr.on('data', function (data) {
      console.log('stderr: ' + data);
    });
    my.process.on('close', function (res) {
      my.running = false;
      console.log('child process exited with code ' + res);
    });
  };

  my.stop = function () {
    if(my.process != null) {
      my.process.kill('SIGHUP');
    }
    my.running = false;
  };

  my.saveCode = function (fileName, code) {
    temp.open(fileName, function(err, info) {
      filePath = info.path;

      fs.write(info.fd, my.addRequiresToCode(code));
      if (err) {
        console.log("Write failed: " + err);
      } else {
        console.log ("Write completed.");
      };
    });

  };

  my.addRequiresToCode = function (code) {
    newCode = "# -*- coding: utf-8 -*-\n";
    newRequire = "require '" + process.env.PWD + "/lib/kidsruby" + "'\n";
    newCode += newRequire;
    newCode += code;
    return newCode;
  };

  return my;
}());
