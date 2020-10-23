$(function(){
  $.ajaxSetup({
    headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')}
  });

  $('#client_filter_room_form').submit(function(e){
    e.preventDefault();
    let type_id = $('.room_type_id').val();
    let view_id = $('.room_view_id').val();
    let price_id = $('#price_id').val();
    let term = $('#term').val();

    let data = [];
    data.push(type_id);
    data.push[view_id];
    data.push[price_id];
    data.push[term];

    if(type_id || view_id || price_id || term){
      $.ajax({
        url: '/rooms',
        method: 'GET',
        data: data
      });
    }
  })

  $('#btn_reset').click(function() {
    let type_id = $('.room_type_id').val();
    let view_id = $('.room_view_id').val();
    let price_id = $('#price_id').val();
    let term = $('#term').val();

    if(type_id || view_id || price_id || term){
      $('.room_type_id').val(null);
      $('.room_view_id').val(null);
      $('#price_id').val(null);
      $('#term').val("");

      let term = null;

      $('#param_term').val(null);

      $.ajax({
        url: '/rooms',
        method: 'GET',
        data: {
          term: term,
        }
      });
    }
  });
});
