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
  $("#stdout").append(decodeURI(newHtml));
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

function stopRun() {
  QTApi["stopRuby()"]();
}

function setRunButtonToStop() {
  $("#run").html(getLocalizedString('buttons', 'stop'));
}

function setStopButtonToRun() {
  $("#run").html(getLocalizedString('buttons', 'run'));
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
  getEditor().setValue('# ' + getLocalizedString('editor', 'your-code') + '\n');
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
  window.editor.setTheme("ace/theme/merbivore");

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

function loadLanguage(lang){
  $.ajax({
    url: 'js/i18n/' + lang + '.js',
    type: "GET",
    crossdomain: true,
    dataType: 'json',
    success: function(data) {
      localizeUI(data);
    },
    error: function(x, s, t) {
      // handles special case for windows webkit
      if (x.status == 0) {
        localizeUI($.parseJSON(x.responseText));
      }
    }
  });
}

function localizeUI(data) {
  saveLocalizedStrings(data);

  $("#run").html(getLocalizedString('buttons', 'run'));
  $("#clear").html(getLocalizedString('buttons', 'clear'));
  $("#open").html(getLocalizedString('buttons', 'open'));
  $("#save").html(getLocalizedString('buttons', 'save'));

  $("#help-link").html(getLocalizedString('tabs', 'help-link'));
  $("#output-link").html(getLocalizedString('tabs', 'output-link'));
  $("#turtle-link").html(getLocalizedString('tabs', 'turtle-link'));

  initEditor();
}

function saveLocalizedStrings(data) {
  var localStrings = data ;
  $("#container").data("localized", localStrings);
}

function getLocalizedString(t, i) {
  var localStrings = $("#container").data("localized");
  return localStrings[t][i];
}

function initUI() {
  language = QTApi["language()"]()
  loadLanguage(language);
}

function initHelp() {
  language = QTApi["language()"]()
  $("#help-iframe").attr("src", "help/" + language + "/index.html");
}

$(document).ready(function() {
  var tabs = $("#tabs").tabs();
  $("#tabs").data("mytabs", tabs);

  $("#run").click(function(e) {
    if ($("#run").html() == getLocalizedString('buttons', 'run')) {
      resizeCanvas();
      $("#run").blur();
      startRun(getEditor());
    } else {
      stopRun();
    }
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
    if (confirm(getLocalizedString('editor', 'confirm-clear')))
      clearCode();

    return false;
  });

  initUI();

  initHelp();

  initTurtle();

  selectTab(0); // default to help tab
});
