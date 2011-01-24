var Ruby = {
  code: function() {
    var scripts = document.getElementsByTagName("script");
    var rubyCode = '';
  
    for (var i = 0; i < scripts.length; i++) {
      var script = scripts[i];
      if ( (script.getAttribute("type") == "text/ruby") || (script.getAttribute("type") == "text/x-ruby") ) {
        rubyCode += script.innerHTML;
      }
    }
    return rubyCode;
  },

  init: function(callback) {
    Ruby.applet();
    Ruby.evalScript(callback);
  },

  evalScript: function(callback) {
    if (document.RubyApplet.evalRuby && document.RubyApplet.hasStarted()) {
      callback(Ruby.eval(Ruby.code()));
    } else {
      setTimeout(function() {
        Ruby.evalScript(callback);
      }, 500);
    }
  },
  
  eval: function(code) {
    return document.RubyApplet.evalRuby(code);
  },

  applet: function() {
  	var applet = document.createElement('applet');
  	applet.setAttribute("archive", "jruby/classes/jruby.jar,jruby/classes/asm.jar");
  	applet.setAttribute("code", "kidsruby.RubyApplet");
		applet.setAttribute("codebase", "jruby/classes");
  	applet.setAttribute("name", "RubyApplet");
  	applet.setAttribute("width", "1000");
  	applet.setAttribute("height", "100");
		
		var param = document.createElement("param");
		param.setAttribute("name", "jruby.eval");
		param.setAttribute("value", "ARGV[0..-1] = %w(-f) ; require 'irb' ; require 'irb/completion' ; Thread.new { IRB.start }")
		applet.appendChild(param);
		
    document.body.appendChild(applet);
  }
};
