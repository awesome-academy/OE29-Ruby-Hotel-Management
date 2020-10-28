$(function(){
  $('.admin-complete').on('click','.bill-complete', function() {
    let url = $(this).data('url');
    let price = $(this).data('bill');
    $.ajax({
      url: url,
      method: 'PATCH',
      data: {
        price : price
      }
    });
  });
});
