function formatCode(t) {
  $(t).snippet("ruby", {style:"pablo", showNum:true})
}

function loadCode(target, src){
  $.ajax({
    url: src,
    type: "GET",
    crossdomain: true,
    dataType: 'text',
    success: function(data) {
      $(target).text(data);
      formatCode(target);
    },
    error: function(x, s, t) {
      // handles special case for windows webkit
      if (x.status == 0) {
        $(target).text(x.responseText);
        formatCode(target);
      }
    }
  });
}

jQuery(document).ready(function($){
  $('article.lesson:gt(0)').hide();
  $('.next-lesson').click(function(){
    var $current =  $("article").filter(function() { return $(this).css("display") == "inline" || $(this).css("display") == "block" });
    if($current.next('article.lesson').length == 0)
      return false;

    $current.hide();
    $current.next().show();
    return $(window).scrollTop(1);
    return false;
  });

  $('.prev-lesson').click(function(){
    var $current =  $("article").filter(function() { return $(this).css("display") == "inline" || $(this).css("display") == "block" });
    if($current.prev('article.lesson').length == 0)
      return false;

    $current.hide();
    $current.prev().show();
    return $(window).scrollTop(1);
    return false;
  });
});
