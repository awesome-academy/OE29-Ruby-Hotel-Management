$(document).on('turbolinks:load', function() {
  $.ajaxSetup({
    headers:
        {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
  });
  //disable button

  var list = [];
  var prices =[];
  var book_prices;
  var price_bill=0;
  var countt;
  var ci;
  var co;
  var dem;

  $('.select').on('change', function() {
    var data = $(this).prop('value');
    var price = $(this).data('price');
    if ($(this).prop('checked') == true) {
      list.push(data);
      prices.push(price);
    } else {
      var index_data = list.indexOf(data);
      var index_price = prices.indexOf(price);
      list[index_data] = null;
      list[index_price] = null;
    }
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
    var user_id = $(this).data('user');
    var book =[];
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
