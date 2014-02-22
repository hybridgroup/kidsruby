//var Keypress = require('keypress')
var KidsRubyServer = (function () {
  var my = {}

  my.app = null;

  function getQuery(req) {
    var i = req.url.indexOf('?');
    return req.url.substr(i+1);
  }

  function responseOK(res, body) {
    body = typeof body !== 'undefined' ? body : 'OK';
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
      updateStdErr(getQuery(req));
      responseOK(res);
    });

    my.app.get('/alert', function(req, res){
      res.send(alert(unescape(getQuery(req))));
    });

    my.app.get('/ask', function(req, res){
     res.send(prompt(unescape(getQuery(req))).toString());
    });

    my.app.get('/gets', function(req, res){
      // TODO: implement
      responseOK(res);
    });

    // turtle routes
    my.app.get('/turtle/init', function(req, res){
      initTurtle();
      responseOK(res);
    });

    my.app.get('/turtle/command', function(req, res){
      code = "getTurtle()." + unescape(getQuery(req));
      eval(code);
      responseOK(res);
    });

    my.app.get('/turtle/background', function(req, res){
      setTurtleBackground(unescape(getQuery(req)));
      responseOK(res);
    });

    my.app.get('/turtle/width', function(req, res){
      responseOK(res, callTurtle(['width']));
    });

    my.app.get('/turtle/height', function(req, res){
      responseOK(res, callTurtle(['height']));
    });

    return my;
  }

  my.listen = function (port) {
    my.app.listen(port);
  }

  return my;
}());
