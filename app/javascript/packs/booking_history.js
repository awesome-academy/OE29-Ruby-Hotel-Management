$(document).on('turbolinks:load', function() {
  $( '#main-content' ).change(function() {
    $('#submit-status').click();
  });

  $('#table-bill').on('click', '.bill-view', function() {
    let url = $(this).data('url');
    $.ajax({
      url: url,
      method: 'GET',
      dataType: 'script',
      data: {}
    });
  });

  $('#table-bill').on('click', '.bill-cancle',function() {
    var sure = confirm(I18n.t('users.show.sure'));
    if (sure == true) {
      let url = $(this).data('url');
      $.ajax({
        url: url,
        method: 'PATCH',
        dataType: 'script',
        data: {}
      });
    }
  });
});
