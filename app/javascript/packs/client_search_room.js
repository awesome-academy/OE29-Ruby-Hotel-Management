$(function(){
  $.ajaxSetup({
    headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')}
  });

  $('#client_form_search_room').submit(function(e){
    e.preventDefault();
    let term = $('.input-search').val();
    $('.room_type_id').val(null);
    $('.room_view_id').val(null);
    $('#price_id').val(null);

    $('#param_term').val(term);

    $.ajax({
      url: '/rooms',
      method: 'GET',
      data: {
        term: term,
      }
    });
  })
});
