var KidsRubyServer = (function () {
  var my = {}

  my.app = null;

  function getQuery(req) {
    var i = req.url.indexOf('?');
    return req.url.substr(i+1);
  }

  function responseOK(res) {
    var body = 'OK';
    res.setHeader('Content-Type', 'text/plain');
    res.setHeader('Content-Length', Buffer.byteLength(body));
    res.end(body);
  }

  my.setup = function (expressApp) {
    my.app = expressApp;

    // main routes
    my.app.get('/append', function(req, res){
      updateStdOut(getQuery(req));
      responseOK(res);
    });

    my.app.get('/appendError', function(req, res){
      // TODO: implement
      responseOK(res);
    });

    my.app.get('/alert', function(req, res){
      // TODO: implement
      responseOK(res);
    });

    my.app.get('/ask', function(req, res){
      // TODO: implement
      responseOK(res);
    });

    my.app.get('/gets', function(req, res){
      // TODO: implement
      responseOK(res);
    });

    // turtle routes
    my.app.get('/turtle/init_turtle', function(req, res){
      // TODO: implement
      responseOK(res);
    });

    my.app.get('/turtle/command_turtle', function(req, res){
      // TODO: implement
      responseOK(res);
    });

    my.app.get('/turtle/background', function(req, res){
      // TODO: implement
      responseOK(res);
    });

    my.app.get('/turtle/width', function(req, res){
      // TODO: implement
      responseOK(res);
    });

    my.app.get('/turtle/height', function(req, res){
      // TODO: implement
      responseOK(res);
    });

    return my;
  }

  my.listen = function (port) {
    my.app.listen(port);
  }

  return my;
}());
