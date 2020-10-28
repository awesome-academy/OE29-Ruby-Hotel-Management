const IMAGE_MAX_SIZE = 5
const FILE_EXTENSION = ['jpeg', 'jpg', 'png']

$(document).on('turbolinks:load', function () {
  $(document).on('change','input[type=file]', function (e) {
    let file_size = $(this)[0].files[0].size / 1024 / 1024;
    let tag = $(this).closest('td').next('td');

    if ($.inArray($(this).val().split('.').pop().toLowerCase(), FILE_EXTENSION) == -1) {
      alert(I18n.t('global.validate_extension_picture'));
      $(this).val(null);
    }

    if (file_size > IMAGE_MAX_SIZE) {
      alert(I18n.t('global.validate_picture_max_size'));
      $(this).val(null);
    } else {
      tag.html(`<img src='${URL.createObjectURL(e.target.files[0])}'>`);
    }
  });
});
