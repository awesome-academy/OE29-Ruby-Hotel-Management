$(function(){
  $('#main-content-admin').on('change','#bill_filter', function() {
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
});
