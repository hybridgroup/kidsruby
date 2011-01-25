function updateStdOut(newHtml) {
	$("#stdout").append(newHtml);
};

function updateStdErr(newHtml) {
	$("#stderr").append(newHtml);
}

function clearOutputs() {
	$.each(["stdout", "stderr"], function(i, item) {
		$("#" + item).html("");
	});
}

function submitRubyCode(editor) {
	var ruby = editor.getCode();
	QTApi['evaluateRuby(QString)'](ruby);
}

$(document).ready(function() {		
	var docWidth = $("body").width();
	
	var editor = CodeMirror.fromTextArea('rubycode', {
	      parserfile: ["../../js/tokenizeruby.js", "../../js/parseruby.js"],
	      stylesheet: "css/rubycolors.css",
	      path: "codemirror/js/",
	      lineNumbers: true,
	      textWrapping: false,
	      indentUnit: 2,
				tabMode: "indent",
				content: $('#rubycode').val(),
	      parserConfig: {},
	      width: docWidth,
	      height: '50%',
				iframeClass: 'editor-window',
	    	autoMatchParens: true
	  });
	
	// Set the output width
	$("#output").width = docWidth;
  
	$("#input button").click(function(e) {
		clearOutputs();
		submitRubyCode(editor);
	});
});