jQuery(document).ready(function($){

  $('article.lesson:gt(0)').hide();
  $('#next-lesson').click(function(){
    var $current =  $("article").filter(function() { return $(this).css("display") == "inline" || $(this).css("display") == "block" });
    if($current.next('article.lesson').length == 0)
      return false;

    $current.hide();
    $current.next().show();
    return false;
  });

  $('#prev-lesson').click(function(){
    var $current =  $("article").filter(function() { return $(this).css("display") == "inline" || $(this).css("display") == "block" });
    if($current.prev('article.lesson').length == 0)
      return false;

    $current.hide();
    $current.prev().show();
    return false;
  });
});

function formatCode(t) {
  $(t).snippet("ruby", {style:"neon", showNum:true})
}

function loadCode(target, src) {
  $(target).load(src, function() {
    formatCode(this);
  });
}
