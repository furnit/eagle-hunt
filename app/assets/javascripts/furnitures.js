//= require jquery-ui

$(document).ready(function(){
  cover_options_btn = $('#cover-options [role=toolbar] .btn#show-cover-options-controls');
  cover_options_btn.data('origin-html', cover_options_btn.html());
  cover_options_btn.click(function(){
    $('#img-f-cover').toggleClass('hidden');
    $('#div-f-cover').toggleClass('hidden');
    $('#cover-options > #cover-options-controls').toggleClass('hidden');
    if($(this).hasClass('btn-success')) {
      backgroundImage.onload();
      $('form[name="cover-config"] input#furniture_cover_configs')
        .val(JSON.stringify({pos: $('#div-f-cover').css('background-position-y')}))
        .closest('form')
          .submit();
    }
  });
  
    backgroundImage = new Image();
    backgroundImage.src = $('#div-f-cover').css('background-image').replace(/"/g,"").replace(/url\(|\)$/ig, "");

    backgroundImage.onload = function() {
        var width = this.width;
        var height = this.height;

        var object = $('#div-f-cover');

        /* Step 1 - Get the ratio of the div + the image */
        var imageRatio = width/height;
        var coverRatio = object.outerWidth()/object.outerHeight();

        /* Step 2 - Work out which ratio is greater */
        if (imageRatio >= coverRatio) {
            /* The Height is our constant */
            var coverHeight = object.outerHeight();
            var scale = (coverHeight / height);
            var coverWidth = width * scale;
        } else {
            /* The Width is our constant */
            var coverWidth = object.outerWidth();
            var scale = (coverWidth / width);
            var coverHeight = height * scale;
        }
        var cover = coverWidth + 'px ' + coverHeight + 'px';
        console.log('scale: ' + scale + ', width: ' + coverWidth + ', height: ' + coverHeight + ', cover property: ' + cover);
    };
  
  
  $('#scroller').slider({
      orientation: "vertical",
      min: -100,
      max: 0,
      value: -50,
      step: 1,
      slide: function( event, ui ) {
        $('#div-f-cover').css('background-position-y', Math.abs(ui.value) + '%');
        console.log(Math.abs(ui.value));
        cover_options_btn
          .html("<span class='fa fa-save'></span> ذخیره‌ تنظیمات پروفایل").closest('.btn')
          .removeClass('btn-default')
          .addClass('btn-success');
      }
  });
});
