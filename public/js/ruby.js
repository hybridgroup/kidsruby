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
	
	log: function(what) {
		document.getElementById('ruby_terminal_output').innerHTML += "<span>"+what+"</span><br>";
	},

  applet: function() {
  	var applet = document.createElement('applet');
  	applet.setAttribute("archive", "jruby/classes/jruby.jar,jruby/classes/asm.jar");
  	applet.setAttribute("code", "kidsruby.RubyApplet");
		applet.setAttribute("codebase", "jruby/classes");
  	applet.setAttribute("name", "RubyApplet");
  	applet.setAttribute("width", "1");
  	applet.setAttribute("height", "1");		
    document.body.appendChild(applet);

		this.log("ready: " + applet);
  }
};
