//= require jquery-ui

$(document).ready(function(){
  cover_options_btn = $('#cover-options [role=toolbar] .btn#show-cover-options-controls');
  cover_options_btn.data('origin-html', cover_options_btn.html());
  cover_options_btn.click(function(){
    $('#cover-options > #cover-options-controls').toggleClass('hidden');
    if($(this).hasClass('btn-success'))
      $('form[name="cover-config"] input#furniture_cover_configs')
        .val(JSON.stringify({pos: $('#cover-img').css('background-position-y')}))
        .closest('form')
          .submit();
  });
  
  $('#scroller').slider({
      orientation: "vertical",
      min: -100,
      max: 0,
      value: -50,
      step: 1,
      slide: function( event, ui ) {
        $('#cover-img').css('background-position-y', Math.abs(ui.value) + '%');
        cover_options_btn
          .html("<span class='fa fa-save'></span> ذخیره‌ تنظیمات پروفایل").closest('.btn')
          .removeClass('btn-default')
          .addClass('btn-success');
      }
  });
});
