$(function() {
  $('#bill').change(function() {
    let email_client = $(this).val();
    let url = $(this).data('url');
    $.ajax({
      url: url,
      type: 'GET',
      data: {
        data: email_client
      }
    });
  });
});
