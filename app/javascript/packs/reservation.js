$(document).on('turbolinks:load', function() {
  $.ajaxSetup({
    headers:
        {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
  });

  let prices = [];
  let list = [];
  let book_prices;
  let price_bill = 0;
  let countt;
  let ci = $('#checkin').val();
  let co = $('#checkout').val();
  let dem;
  let list_id = ci.concat(co);
  let prices_id = ci.concat(co).concat('prices_id');

  let room_id = $('#contain_room_id').val();

  if(room_id != null){
    $('#room-1').prop('checked', true);
    let price_first = $('#room-1').data('price');
    list =  JSON.parse(localStorage.getItem(list_id)) || ['1'];
    prices =  JSON.parse(localStorage.getItem(prices_id)) || [price_first];
  }

  for(let i = 0; i < list.length; i++){
    $('#room-' + list[i]).prop('checked', true);
  }

  $('.select').on('change', function() {
    let data = $(this).prop('value');
    let price = $(this).data('price');
    if ($(this).prop('checked') == true) {
      list.push(data);
      prices.push(price);
    } else {
      let index_data = list.indexOf(data);
      let index_price = prices.indexOf(price);
      list[index_data] = null;
      prices[index_price] = null;
    }
    localStorage.setItem(list_id, JSON.stringify(list));
    localStorage.setItem(prices_id, JSON.stringify(prices));
  });

  $('#reservation').on('click', function() {
    ci = $(this).data('checkin');
    co = $(this).data('checkout');
    countt= (new Date(co) - new Date(ci))/86400000+1;
    function myFunction(value, index, array) {
      return value * countt;
    }
    book_prices = prices.map(myFunction);
    dem = list.length;
    for(let i = 0; i<dem ;i++) {
      price_bill+= book_prices[i];
    }
    let list_room = [];
    list_room = list;
    $.ajax({
      url: '/bills',
      method: 'get',
      data: {
        count: countt,
        total: price_bill,
        data: list_room,
        checkin: ci,
        checkout: co,
      },
    });
  });

  $('#book').on('click', function(){
    localStorage.clear();
    let user_id = $(this).data('user');
    let book = [];
    for(let i=0; i<dem ;i++){
      book[i] = {
        price: book_prices[i],
        status: "available",
        checkin: ci,
        checkout: co,
        room_id: list[i]
      }
    }
    $.ajax({
      url: '/bills',
      method: 'post',
      data: {
        status: "waiting",
        user_id: user_id,
        price: price_bill,
        bookings_attributes: book
      }
    });
  });
});
