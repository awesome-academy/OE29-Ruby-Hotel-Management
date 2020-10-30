$(document).on('turbolinks:load', function() {
  $('.btn-clear').click(function(e){
    $('#arrow-sort-price-up').removeClass('hidden');
    $('#arrow-sort-price-down').removeClass('hidden');

    params_search = [name, type_id, view_id, price];
    params_search.forEach(param => $(param).val(null));

    let url = $(this).attr('data-url');

    $.ajax({
      url: url,
      method: 'GET',
      data: {
        filter: 1
      }
    });
  });

  $(document).on('click', '#arrow-sort-price-up', function(){
    $('#arrow-sort-price-up').addClass('hidden');
    $('#arrow-sort-price-down').removeClass('hidden');

    let name = $('#name').val();
    let type_id = $('#type_id').val();
    let view_id = $('#view_id').val();
    let price = 'asc';
    let url = $(this).attr('data-url');
    $.ajax({
      url: url,
      method: 'GET',
      data: {
        name: name,
        type_id: type_id,
        view_id: view_id,
        price: price,
        filter: 1
      }
    });
  })

  $(document).on('click', '#arrow-sort-price-down', function(){
    $('#arrow-sort-price-down').addClass('hidden');
    $('#arrow-sort-price-up').removeClass('hidden');

    let name = $('#name').val();
    let type_id = $('#type_id').val();
    let view_id = $('#view_id').val();
    let price = 'desc';
    let url = $(this).attr('data-url');
    $.ajax({
      url: url,
      method: 'GET',
      data: {
        name: name,
        type_id: type_id,
        view_id: view_id,
        price: price,
        filter: 1
      }
    });
  })
});
