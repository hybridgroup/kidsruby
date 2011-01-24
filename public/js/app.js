$(document).ready(function() {	
	function echoRuby(ruby) {
	  document.getElementById("output").innerHTML = Ruby.eval(ruby);
	};
	
	var editor = CodeMirror.fromTextArea('rubycode', {
      parserfile: ["../../js/tokenizeruby.js", "../../js/parseruby.js"],
      stylesheet: "css/rubycolors.css",
      path: "codemirror/js/",
      lineNumbers: true,
      textWrapping: false,
      indentUnit: 2,
      parserConfig: {},
      width: '500px',
      height: '30%',
	    autoMatchParens: true
  });

	$("#run").click(function(e) {
		var ruby = document.getElementById('rubycode').value
		
		alert(Ruby.eval(ruby));
	});
  // Handler for .ready() called.
  Ruby.init(function(result) {
    document.getElementById("output").innerHTML = result;
  });

});