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

function initTurtle() {
  var turtle = new Pen("turtle-canvas");
  turtle.turn(180);
  turtle.jump(100, 100);
	$("#turtle").data('turtle', turtle);
}

function callTurtle(arguments) {
  var turtle = $("#turtle").data('turtle');
  var command = Array.prototype.shift.call(arguments);
  return turtle[command].apply(turtle, arguments);
}


$(document).ready(function() {		
	var docWidth = $("body").width();
  var docHeight = $(document).height();
	
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
	      height: '95%',
				iframeClass: 'editor-window',
	    	autoMatchParens: true
	  });
	
	// Set the output width
	$("#output").width = docWidth;
  
	$("#input button").click(function(e) {
		clearOutputs();
		submitRubyCode(editor);
	});
	
	initTurtle();

  $("#tabs").tabs();
  //$("#help iframe").css("height", docHeight-200);
  console.info(docHeight);
});
