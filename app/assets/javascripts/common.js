$(document).on('ready', function() {
  document.NProgress = window.NProgress;
  // setting config for 1min delay length
  document.NProgress.configure({
    speed: 500,
    minimum: 0.05,
    trickleRate: 0.03
  });
  // set bootbox locale
  bootbox.setLocale('fa');  
  // set bootbox default args
  bootbox.setDefaults({
  	closeButton: false
  });
});

function alert_error(msg) {
	bootbox.alert({title: '<span class="text-danger"><span class="fa fa-exclamation-triangle"></span> خطا در انجام عملیات!</span>', message: msg});
}

$(document).on('ready turbolinks:load', function(){
	// define format proto-type for string class 
	String.prototype.format = function () {
    var args = [].slice.call(arguments);
    return this.replace(/(\{\d+\})/g, function (a){
        return args[+(a.substr(1,a.length-2))||0];
    });
	};
  // auto resize any textarea
  $('textarea').autosize();
  // append CSRF token to headers of all ajax posts
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });
  // recursively delete the alerts
  var delete_alerts = function () {
    $('#page-alerts .alert:not(.alert-danger):last')
      .fadeOut(500, function() {
        $(this).remove();
        if($('#page-alerts .alert:not(.alert-danger):first').length)
          setTimeout(delete_alerts, 2500);
      });
  };
  // remove the alerts after some time
  setTimeout(delete_alerts, 5000);
  // things should be applied to documents
  var apply_to_documents = function(){
    // make remote form validatable
    $('form[data-remote]:not(.ajaxified)').on('ajax:error', function(e, data, status, xhr) {
      if(($(this).has('input[type!=hidden]').length + $(this).has('select').length + $(this).has('textarea').length) > 0) {
        form = $(this);
        errors = data.responseJSON;
        model_name = form.attr('name') || '';
        form.find('.has-error').removeClass('has-error').find('.help-block').remove();
        if(Array.isArray(errors)) {
	        $.each(errors, function(field, messages) {
	          input = form.find('input[type!=hidden], select, textarea, div[name]').filter(function() {
	            name = $(this).attr('name');
	            if(name)
	              return name.match(new RegExp(model_name + '\\[' + field + '\\(?'));
	          });
	          input.closest('.form-group').addClass('has-error');
	          input.parent().find('.help-block').remove();
	          input.parent().append('<span class="help-block">' + $.map(messages, function(m) { return m.charAt(0).toUpperCase() + m.slice(1); }).join('<br />') + '</span>');
	        });
	        form.find('.has-error:first input:first, .has-error:first select:first, .has-error:first textarea:first').focus();
        } else if(typeof(errors) === "object" && errors.message !== undefined) {
        	alert_error(errors.message);
        }
      }
    }).on('ajax:success', function(e, data, status, xhr){
    	// redirect if any redirection header specified
    	if(xhr.getResponseHeader('Location'))
    		window.location = xhr.getResponseHeader('Location');
    }).addClass('ajaxified');
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
	    $("#inline-html-call-block"+blockid).load($(this).attr('href'), function(response, status, xhr){
	    	if(status == "error") { $this.removeClass('active'); return; }
	      var html = $(this).html();
	      var body = html;
	      var title = '';
	      if(body.length === 0) return;
	
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
	      	$(this).find(".btn").blur();
	        $(this).find('[autofocus]').focus();
			    $(this).scrollTop(0);
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
    // auto resize any text area
    $('textarea:not([data-noresize])').not('.autoresized').autosize().addClass('autoresized');
    // enable tooltips
    $('[data-toggle="tooltip"]:not(.tooltipfied)').tooltip().addClass('tooltipfied');
    // enable popover
    $('[data-toggle="popover-hover"]:not(.popoverified)').popover({trigger: 'hover', placement: 'top'}).addClass('popoverified');
    // for select pickers
    $('.selectpicker:not(.selectpickerified)').selectpicker().addClass('selectpickerified');
    // prevent default empty links
    $("a[href='#']:not(.hash-disabled)").click(function(e) { e.preventDefault(); }).addClass('hash-disabled').blur();
    // make sure auto-focus happen
    setTimeout(function() { $(".btn").blur(); $("[autofocus]:first").focus(); }, 300);
  };
  // apply to current document as well
  apply_to_documents();
  // and any other docuemnts loaded by ajax
  $(document).ajaxSuccess(apply_to_documents);
  // making alerts go away by clicking on the X button
  $('#page-alerts .fa-times').click(function(){
    $(this).parents('.alert').fadeOut(300, function() { $(this).remove(); });
  });
}).ajaxError(function(e, xhr){
  // i.e users sent wrong data to the server OR abort!!
  if(xhr.status === 422 || xhr.status === 0 || xhr.statusText === "abort") return;
  alert_error('خطایی در هنگام اجرای عملیات رخ داده‌ است؛ لطفا دوباره تلاش کنید و در صورت رخداد مجدد این خطا به تیم توسعه‌ی سایت اطلاع دهید و <b>بن تخفیف بگیرید</b>!');
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