function updateOutputView(newHtml) {
	$("#output").html(newHtml);
}

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

	$("#input button").click(function(e) {
		var ruby = $('#input textarea').val();
		QTApi.evaluateRuby(ruby);
	});
	
});