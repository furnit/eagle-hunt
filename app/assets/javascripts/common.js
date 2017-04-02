$(document).on('ready turbolinks:load', function(){
  // auto resize any textarea
  $('textarea').autosize();
  // append CSRF token to headers of all ajax posts
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });
  // remove the alerts after some time
  setTimeout(function(){ $('#page-alerts .alert').fadeOut(1000, function() { $(this).remove(); }); }, 2000);
  // setting config for 1min delay length
  document.NProgress.configure({
    speed: 500,
    minimum: 0.05,
    trickleRate: 0.03
  });
  // things should be applied to documents
  var apply_to_documents = function(){
    // make remote form validatable
    $('form[data-remote]').not('.ajaxified').on('ajax:error', function(e, data, status, xhr) {
      if($(this).has('input[type!=hidden]').length + $(this).has('select').length + $(this).has('textarea') > 0) {
        form = $(this);
        errors = data.responseJSON;
        model_name = form.attr('name') || '';
        $.each(errors, function(field, messages) {
          input = form.find('input, select, textarea').filter(function() {
            name = $(this).attr('name');
            if(name)
              return name.match(new RegExp(model_name + '\\[' + field + '\\(?'));
          });
          input.closest('.form-group').addClass('has-error');
          input.parent().find('.help-block').remove();
          input.parent().append('<span class="help-block">' + $.map(messages, function(m) { return m.charAt(0).toUpperCase() + m.slice(1); }).join('<br />') + '</span>');

        });
      }
    }).addClass('ajaxified');
    // auto resize any text area
    $('textarea:not([data-noresize])').not('.autoresized').autosize().addClass('autoresized');
    // enable tooltips
    $('[data-toggle="tooltip"]').tooltip();
  };
  // apply to current document as well
  apply_to_documents();
  // and any other docuemnts loaded by ajax
  $(document).ajaxSuccess(apply_to_documents);
  // making alerts go away by clicking on the X button
  $('#page-alerts .fa-times').click(function(){
    $(this).parents('.alert').fadeOut(300, function() { $(this).remove(); });
  });
  // load inline html from links
  $('.inline-html-call:not(.active)').click(function(e) {
    e.preventDefault();
    if($(this).hasClass('active')) return;
    // don't recall it when active'
    $this = $(this);
    $this.addClass('active');
    // define counter
    if($('body').data('inline-html-call-counter') === undefined)
      $('body').data('inline-html-call-counter', 0);
    $('body').data('inline-html-call-counter', $('body').data('inline-html-call-counter') + 1);
    blockid = $('body').data('inline-html-call-counter');
    $('body').append('<div id="inline-html-call-block'+blockid+'" class="hidden inline-html-call-modal"></div>');
    $("#inline-html-call-block"+blockid).load($(this).attr('href'), function(){
      var html = $(this).html();
      var body = html;
      var title = '';

      if($(html).find('> *:first').is('legend')) {
        var wrapped = $("<div>" + html + "</div>");
        wrapped.find('legend:first').remove();
        var body = wrapped.html();
        var title = $(html).find('legend:first').html();
      }

      var dialog = bootbox.dialog({
        title: title,
        message: body,
        backdrop: true,
        onEscape: function() { $('.inline-html-call-modal').remove(); $this.removeClass('active'); },
        size: 'large'
      }).on('shown.bs.modal',function(){
        $(this).find('[autofocus]').focus();
      });
      $(this).remove();
      // if any remote link clicked, make the progress bar bound to the model
      $('.bootbox.modal .modal-body a[data-remote]').click(function(e) {
        document.NProgress.configure({
          parent: '.bootbox.modal .modal-body',
          template: '<div class="bar" role="bar"><div class="peg"></div></div><div class="spinner-left" role="spinner"><div class="spinner-icon"></div></div>'
        });
        // on ajax complete reset the progress bar boundaries
        $(this).bind('ajax:complete', function(){ document.NProgress.configure({parent: 'body'}); });
      });
    });
  });
}).ajaxError(function(){
  bootbox.alert({title: 'خطا در انجام عملیات!', message: 'خطایی در هنگام اجرای عملیات رخ داده‌ است؛ لطفا دوباره تلاش کنید و در صورت رخداد مجدد این خطا به تیم توسعه‌ی سایت اطلاع دهید و <b>بن تخفیف بگیرید</b>!'});
});

function update_the_shopping_cart_banner(count) {
  if(count > 0)
    $('.shopping-cart-tag')
      .html('سبد خرید (' + count.toString() + ")")
      .parents('li')
        .addClass('has-shopping-cart');
  else
    $('.shopping-cart-tag')
      .html('سبد خرید')
      .parents('li')
        .removeClass('has-shopping-cart');

  $('.shopping-cart-tag')
    .parents('.magnifiable')
      .addClass('magnifiable-enabled');

  setTimeout(function() {
      $('.shopping-cart-tag').parents('.magnifiable').removeClass('magnifiable-enabled');
  }, 500);
}