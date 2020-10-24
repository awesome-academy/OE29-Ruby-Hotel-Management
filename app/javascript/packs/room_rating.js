$(function() {
  $.ajaxSetup({
    headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')}
  });

  $(document).on('click','.rating_star', function(event) {
    event.stopImmediatePropagation();
    let room_id = $(this).attr('data-room-id');
    let score = $(this).attr('data-stars');
    let url = $(this).attr('data-url');
    let method = $(this).attr('data-method');

    $.ajax({
      url: url,
      method: method,
      data: {
        room_id: room_id,
        score: score
      }
    });
  });
});
