$(function() {
  $.ajaxSetup({
    headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')}
  });

  $(document).on('click','.open-reply', function() {
    let comment_id = $(this).attr('data-comment-id');
    $('#form-reply-' + comment_id).removeClass('hidden');
  });
});
