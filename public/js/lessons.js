jQuery(document).ready(function($){

  $('article.lesson:gt(0)').hide();
  $('#next-lesson').click(function(){
    var $current = $('article.lesson:visible');
    if($current.next('article.lesson').length == 0)
      return false;
      
    $current.slideUp(500, function(){
      $(this).next().slideDown(500);
    });
    return false;
  });

  $('#prev-lesson').click(function(){
    var $current = $('article.lesson:visible');
    if($current.prev('article.lesson').length == 0)
      return false;
  
    $current.slideUp(500, function(){
      $(this).prev().slideDown(500);
    });
    return false;
  });
});
