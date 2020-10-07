require('@rails/ujs').start()
require('turbolinks').start()
require('channels')
require('jquery')
import 'bootstrap'
import '@fortawesome/fontawesome-free/js/all';
require('admin-lte');
import '../stylesheets/application';

//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
require("@nathanvda/cocoon")

$(document).on('turbolinks:load', function () {
  $.ajaxSetup({
    headers:
      { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
  });
  let list = [];
  $(".select").on("click", function () {
    if ($(this).prop('checked') == true) {
      var data = $(this).prop('value');
      list.push(data);
    }

  });
  // $(".btn-select").on("click", function () {
  //   var data = $(this).data('id');
  //   list.push(data);

  // });
  $("#reservation").on("click", function () {
    let list_room = [];
    list_room = list;
    list = [];
    $.ajax({
      url: '/reservations',
      method: 'post',
      data: {
        data: list_room
      }
    });
  });
});
``
