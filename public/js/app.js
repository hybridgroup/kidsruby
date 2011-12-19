function selectTab(id) {
  $("#tabs").data("mytabs").tabs("select", id);
}

function deleteLastStdIn() {
  removeCursor();
  var str = $("#stdin").text();
  var newStr = str.substring(0, str.length-1);
  $("#stdin").html('');
  updateStdIn(newStr);
}

function updateStdIn(newHtml) {
  $("#stdin").append(newHtml);
  appendCursor($('#stdin'));
}

function removeCursor() {
  $('.cursor').remove();
}

function appendCursor() {
  removeCursor();
  $('#stdin').append("<span class='cursor'>|</span>");
  setCursorBlinkInterval();
}

function setCursorBlinkInterval() {
  if (blinkInterval!='undefined') {
    clearInterval(blinkInterval);
  }

  var blinkInterval = setInterval(function() {
    $('.cursor').fadeTo(500, 0.5);
    $('.cursor').fadeTo(500, 0);
  }, 0);
}

function removeStdIn() {
  $("#stdin").remove();
}

function acceptStdIn() {
  if ( !$("#stdin").length ) {
    $('#output').append("<div id='stdin'></div>");
  }
  appendCursor();
  scrollToOutputEnd()
}

function cutStdInToStdOut() {
  copyStdIntoStdOut();
  removeStdIn();
}
function copyStdIntoStdOut() {
  $("#stdout").append($("#stdin").html());
}

function updateStdOut(newHtml) {
  $("#stdout").append(unescape(newHtml));
  scrollToOutputEnd()
};

function updateStdErr(newHtml) {
  $("#stderr").append(unescape(newHtml));
  scrollToOutputEnd()
}

function startRun() {
  detectTurtleCode() ? selectTab(2) : selectTab(1);
  clearOutputs();
  resetTurtle();
  submitRubyCode();
}

function clearOutputs() {
  $.each(["stdout", "stderr"], function(i, item) {
    $("#" + item).html("");
  });
}

function submitRubyCode() {
  var ruby = getEditor().getValue();
  QTApi["evaluateRuby(QString)"](ruby);
}

function openRubyCode() {
  QTApi["openRubyFile(QString)"]("");
}

function saveRubyCode() {
  var ruby = getEditor().getValue();
  QTApi["saveRubyFile(QString)"](ruby);
}

function getAce() {
  return window.editor;
}

function getEditor() {
  return getAce().getSession();
}

function clearCode() {
  getEditor().setValue("");
  clearOutputs();
}

function addCode(newCode) {
  currentCode = getEditor().getValue();
  if (currentCode != "") {
    currentCode = currentCode + "\n"
  }
  getEditor().setValue( currentCode + newCode);
}

function detectTurtleCode() {
  var ruby = getEditor().getValue();
  return ruby.match(/^\s+?Turtle\.start/) ? true : false;
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

function setDefaultEditorContent() {
  // set initial value and position
  getEditor().setValue("# Type in your code just below here:\n");
  getAce().gotoLine(2);
}

function initEditor() {
  window.editor = ace.edit("rubycode");

  // themes
  window.themes = [
    "clouds", "clouds_midnight", "cobalt", "crimson_editor", "dawn", "eclipse",
    "idle_fingers", "kr_theme", "merbivore", "merbivore_soft",
    "mono_industrial", "solarized_dark", "solarized_light", "textmate",
    "twilight", "vibrant_ink"
      ]
      window.editor.setTheme("ace/theme/clouds");

  // ruby mode
  var RubyMode = require("ace/mode/ruby").Mode;
  getEditor().setMode(new RubyMode());

  // use soft tabs
  getEditor().setTabSize(2);
  getEditor().setUseSoftTabs(true);

  // initialize content
  setDefaultEditorContent();
}

function scrollToOutputEnd() {
  var height = 0
  $('#output').children().each(function() {
    height += $(this).height();
  });
  $('#output').scrollTop(height);
}

$(document).ready(function() {
  var tabs = $("#tabs").tabs();
  $("#tabs").data("mytabs", tabs);

  $("#run").click(function(e) {
    resizeCanvas();
    startRun(getEditor());
    return false;
  });

  $("#open").click(function(e) {
    openRubyCode(getEditor());
    return false;
  });

  $("#save").click(function(e) {
    saveRubyCode(getEditor());
    return false;
  });

  $("#turtle").resize(function() {
    resizeCanvas();
  });

  $('#clear').click(function(e) {
    clearCode();
    return false;
  });

  initTurtle();

  selectTab(0); // default to help tab

  initEditor();
});
