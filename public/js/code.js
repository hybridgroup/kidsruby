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
