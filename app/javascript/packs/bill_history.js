$(function(){
  let bill_created_at_start = null;
  let bill_created_at_end = null;
  $('#bill_created_at_start').change(function(){
    bill_created_at_start = $(this).val();
  });

  $('#bill_created_at_end').change(function(){
    bill_created_at_end = $(this).val();
  })

  if(bill_created_at_start && bill_created_at_end){
    let params = [];
    params.push(bill_created_at_start);
    params.push(bill_created_at_end);

    $.ajax({
      url: '/admin_bill_history_path',
      type: 'POST',
      data: params
    });
  }
});
