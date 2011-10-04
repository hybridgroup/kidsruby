function selectTab(id) {
  $("#tabs").data("mytabs").tabs("select", id);
}

function deleteLastStdIn() {
  var str = $("#stdin").html();
  var newStr = str.substring(0, str.length-1);
  $("#stdin").html(newStr);
}

function updateStdIn(newHtml) {
  if ( !$("#stdin").length ) {
    updateStdOut("<div id='stdin'></div>");
  }
  $("#stdin").append(newHtml);
}

function cutStdInToStdOut() {
  copyStdIntoStdOut();
  removeStdIn();
}

function removeStdIn() {
  $("#stdin").remove();
}

function copyStdIntoStdOut() {
  $("#stdout").append($("#stdin").html());
}

function updateStdOut(newHtml) {
  $("#stdout").append(unescape(newHtml));
};

function updateStdErr(newHtml) {
  $("#stderr").append(unescape(newHtml));
}

function startRun(editor) {
  selectTab(1);
  clearOutputs();
  resetTurtle();
  submitRubyCode(editor);
}

function clearOutputs() {
  $.each(["stdout", "stderr"], function(i, item) {
    $("#" + item).html("");
  });
}

function submitRubyCode(editor) {
  var ruby = editor.getSession();
  QTApi["evaluateRuby(QString)"](ruby);
}

function openRubyCode() {
  QTApi["openRubyFile(QString)"]("");
}

function saveRubyCode(editor) {
  var ruby = editor.getSession();
  QTApi["saveRubyFile(QString)"](ruby);
}

function getEditor() {
  return $("#rubycode").data("editor");
}

function clearCode() {
  getEditor().setCode("");
}

function addCode(code) {
  getEditor().setCode(getEditor().getSession() + "\n" + code);
}

function initTurtle() {
  var turtle = new Pen("turtle-canvas");
  turtle.center();
  $("#turtle").data("turtle", turtle);
  selectTab(2);
}

function resetTurtle() {
  var turtle = getTurtle();
  turtle.center();
  setTurtleBackground("#white");
}

function callTurtle(arguments) {
  var turtle = getTurtle();
  var command = Array.prototype.shift.call(arguments);
  return turtle[command].apply(turtle, arguments);
}

function getTurtle() {
  return $("#turtle").data("turtle");
}

function setTurtleBackground(color) {
  $("#turtle").css("backgroundColor", unescape(color));
}

function resizeCanvas() {
  var pnl = $("#tabs").find(".ui-tabs-panel:visible");
  canvas = document.getElementById("turtle-canvas");
  canvas.width = pnl.width();
  canvas.height = pnl.height();
}

$(document).ready(function() {
  var docWidth = $("body").width();
  var docHeight = $(document).height();

  // Set the output width
  $("#output").width = docWidth;

  var tabs = $("#tabs").tabs();
  $("#tabs").data("mytabs", tabs);

  $("#run").click(function(e) {
    resizeCanvas();
    startRun(editor);
    return false;
  });

  $("#open").click(function(e) {
    openRubyCode(editor);
    return false;
  });

  $("#save").click(function(e) {
    saveRubyCode(editor);
    return false;
  });

  $("#turtle").resize(function() {
    resizeCanvas();
  });

  initTurtle();

  selectTab(0); // default to help tab
});
