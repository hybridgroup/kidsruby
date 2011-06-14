jQuery(document).ready(function($){
  var $current = $('article.lesson');

  $('#next-lesson').click(function(){
    followUnlessMatches('#next', this.href);
    return false;
  });

  $('#prev-lesson').click(function(){
    followUnlessMatches('#back', this.href);
    return false;
  });

  function followUnlessMatches(str, href) {
    if(href.match(str)) {
      return false;

    } else {
      $('article.lesson').slideUp(500, function(){
        window.location = href;
      });
    }
  }
});
