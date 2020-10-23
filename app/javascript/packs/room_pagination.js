const LOADROOMS = 365;

$(document).on('turbolinks:load', function () {
  if ($('.pagination').length && $('#list_room').length) {
    $(window).on('scroll', function () {
      let _url = $('.pagination .next_page a').attr('href');
      let url = _url ? _url : $('.pagination .next a').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - LOADROOMS && $.active === 0) {
        $.getScript(url);
      }
    });
  }
});
