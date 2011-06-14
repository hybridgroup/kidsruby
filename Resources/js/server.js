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
        } else if (generalCommand){
          // do general command
          var cmd = generalCommand[1]
          if (cmd == "alert") {
            alert(unescape(query));
            this.validResponse(response)
          } else if (cmd == "ask") {
            this.validResponse(response, prompt(unescape(query)));      
          } else if (cmd == "append") {
            //param = URI.decode(url.encodedQuery.to_s)          
            //@parent.append(param)
            //connection.write validResponse("OK")
            this.validResponse(response)
          } else if (cmd == "appendError") {
            //@parent.appendError(body)
            //connection.write validResponse("OK")
            this.validResponse(response)
          } else if (cmd == "gets") {
            //connection.write validResponse(@parent.gets)
            this.validResponse(response)
          } else {
            this.errorResponse(response);
          }      
        } else {
          this.errorResponse(response);
        }

  		}
  		catch(e)
  		{
  		  // todo: handle error
  		  this.errorResponse(response);
  		  server.close();
  			//callback.failed(e);
  		}
    });
  },

  validResponse: function(response, val) {
    if (val == null) {val = '';}
    response.setContentType('text/plain');
		response.setContentLength(val.length);
		response.setStatusAndReason('200','OK');
		response.write(val);
  },

  errorResponse: function(response) {
    response.setContentType('text/plain');
		response.setStatusAndReason('400','Bad Request');
  }
};