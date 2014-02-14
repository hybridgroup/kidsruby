var Runner = (function () {
  var my = {}

  function runLocation() {
    // TODO: temp file location
    return "\/home\/ron\/Development\/kidsruby\/kidsruby\/kidscode.rb";
  }

  my.running = false;
  my.process = null;

  my.run = function (code) {
    my.saveCode(runLocation(), code);
    my.process = cp.spawn('ruby', [runLocation()]);
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

  my.saveCode = function (fileLocation, code) {
    fs.writeFile(fileLocation, my.addRequiresToCode(code), function (err) {
      if (err) {
        console.log("Write failed: " + err);
        return;
      }
      console.log("Write completed.");
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
