Runner = function(code) {
	this.code = code;
	this.tempFile = this.saveCode();
};

Runner.prototype = {
	run: function() {
    var process = Titanium.Process.createProcess(['ruby', this.tempFile]); //, environment, stdin, stdout, stderr);
    process.launch();
	},
	saveCode: function() {
    var tempDir = Titanium.Filesystem.createTempDirectory();
    var fileName = Titanium.Filesystem.getFile(tempDir, 'kidcode.rb');
    fileName.write(this.buildCode(this.code));
    return fileName;
	},
	buildCode: function(code) {
	  var newCode = "require '" + Titanium.Filesystem.getFile(Titanium.Filesystem.getResourcesDirectory()).nativePath() + "/lib/kidsruby" + "'\n"
	  newCode = newCode + code ;
	  return newCode ;
	}	
};