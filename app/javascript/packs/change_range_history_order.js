$(function(){
  $.ajaxSetup({
    headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')}
  });

  $('#bill_filter').change(function() {
    let range = $(this).val();

    $.ajax({
      url: '/admin/bill_history',
      method: 'GET',
      data: {
        range: range
      }
    });
  });

  $('#form_bill_history').submit(function(e){
    e.preventDefault();
    let url = $(this).attr('action');
    let start_date = $('#form_bill_history #start_date').val();
    let end_date = $('#form_bill_history #end_date').val();
    if(start_date > end_date){
      alert(I18n.t('admin.dashboard.index.start_date_can_not_bigger_end_date'));
    }else{
      $.ajax({
        url: url,
        method: 'GET',
        data: {
          start_date: start_date,
          end_date: end_date
        }
      });
    }
  })
});
