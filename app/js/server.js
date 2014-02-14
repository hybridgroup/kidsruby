var KidsRubyServer = (function () {
	var my = {}

	my.app = null;

	function responseOK(res) {
		var body = 'OK';
    res.setHeader('Content-Type', 'text/plain');
    res.setHeader('Content-Length', Buffer.byteLength(body));
    res.end(body);
	}

	my.setup = function (expressApp) {
		my.app = expressApp;

		my.app.get('/append', function(req, res){
	    var i = req.url.indexOf('?');
	    var query = req.url.substr(i+1);
	    updateStdOut(query);
	    responseOK(res);
  	});

  	return my;
	}

	my.listen = function (port) {
		my.app.listen(port);
	}

	return my;
}());
