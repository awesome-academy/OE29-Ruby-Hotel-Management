const LOADROOMS = 365;

$(document).on('turbolinks:load', function () {
  if ($('.pagination').length && $('#list_room').length) {
    $(window).on('scroll', function(){
      url = $('.pagination .next_page a').attr('href');
      if(url) {
        url = url;
      } else {
        url= $('.pagination .next a').attr('href');
      }
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - LOADROOMS) {
        $.getScript(url);
      }
    });
  }
});
