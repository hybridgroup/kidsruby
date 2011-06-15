KidsRubyServer = function() {
	this.server = Titanium.Network.createHTTPServer();
};

KidsRubyServer.prototype = {
  start: function() {
    var result = null;
    this.server.bind(8080, function(request, response) {
  	  try
  		{
  		  var command = parseUri(request.getURI()).path;
        var turtleCommand = /\/turtle\/(.*)/.exec(command);
        var generalCommand = /\/(.*)/.exec(command);
        var query = parseUri(request.getURI()).query;
        
        if (turtleCommand) {
          // do turtle command
          var cmd = turtleCommand[1]
          if (cmd == "init_turtle") {
            initTurtle();
            response.setContentType('text/plain');
            response.write("OK");
          } else if (cmd == "command_turtle") {
            eval("getTurtle()." + query)
            response.setContentType('text/plain');
            response.write("OK");
          } else if (cmd == "background") {
            setTurtleBackground(query);
            response.setContentType('text/plain');
            response.write("OK");
          } else if (cmd == "width") {
            response.setContentType('text/plain');
            response.write(callTurtle(['width']));
          } else if (cmd == "height") {
            response.setContentType('text/plain');
            response.write(callTurtle(['height']));
          } else {
            response.setContentType('text/plain');
            response.setStatusAndReason('400','Bad Request');
          }
        } else if (generalCommand) {
          // do general command
          var cmd = generalCommand[1]
          if (cmd == "alert") {
            alert(unescape(query));
            response.setContentType('text/plain');
            response.write("OK");
          } else if (cmd == "ask") {
            response.setContentType('text/plain');
            response.write(prompt(unescape(query)));
          } else if (cmd == "append") {
            updateStdOut(query);
            response.setContentType('text/plain');
            response.write("OK");
          } else if (cmd == "appendError") {
            updateStdErr(query);
            response.setContentType('text/plain');
            response.write("OK");
          } else if (cmd == "gets") {
            //connection.write validResponse(@parent.gets)
            this.validResponse(response)
          } else {
            response.setContentType('text/plain');
            response.setStatusAndReason('400','Bad Request');
          }      
        } else {
          response.setContentType('text/plain');
          response.setStatusAndReason('400','Bad Request');
        }

  		}
  		catch(e)
  		{
  		  // todo: handle error
        response.setContentType('text/plain');
        response.setStatusAndReason('400','Bad Request');
        server.close();
  		}
    });
  }
};