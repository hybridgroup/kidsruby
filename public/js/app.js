$(document).ready(function() {		
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
		var ruby = document.getElementById('rubycode').value;
		var output = QTApi.evaluateRuby(ruby);
		document.getElementById("output").innerHTML = output;
	});
	
});