$(function(){
  $('#admin-reservation').on('change','#bill_filter', function() {
    let range = $(this).val();
    let url = $(this).data('url');
    $.ajax({
      url: url,
      method: 'GET',
      data: {
        range: range
      }
    });
  });
  $('#admin-reser').on('click', '.admin-bill-cancle',function() {
    let sure = confirm(I18n.t('users.show.sure'));
    if (sure == true) {
      let url = $(this).data('url');
      $.ajax({
        url: url,
        method: 'PATCH',
        data: {
          data: "cancelled"
        }
      });
    }
  });
  $('.admin-accept').on('click', '.bill-accept',function() {
    let sure = confirm(I18n.t('users.show.sure'));
    if (sure == true) {
      let url = $(this).data('url');
      $.ajax({
        url: url,
        method: 'PATCH',
        data: {
          data: "accept"
        }
      });
    }
  });
});
