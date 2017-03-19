// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//! require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootbox
//= require bootbox-delete-confirm
//! require turbolinks
//= require nprogress
//= require jquery.autosize
//= require nprogress-ajax
//! require nprogress-turbolinks

$(document).ready(function(){
	// auto resize any textarea
	$('textarea').autosize();
	// append CSRF token to headers of all ajax posts
	$.ajaxSetup({
	  headers: {
	    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
	  }
	});
	// setting config for 1min delay length
	NProgress.configure({
	  speed: 500,
	  minimum: 0.05,
	  trickleRate: 0.03
	});
	$(document).ajaxSuccess(function(){
		// make remote form validatable
		$('form[data-remote]').not('.ajaxified').on('ajax:error', function(e, data, status, xhr) {
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
		  
		}).addClass('ajaxified');
		// auto resize any text area
		$('textarea').not('.autoresized').autosize().addClass('autoresized');
	});
	// making alerts go away by clicking on the X button
	$('#page-alerts .fa-times').click(function(){
		$(this).parents('.alert').fadeOut(300, function() { $(this).remove(); });
	});
	// load inline html from links
	$('.inline-html-call').click(function(e) {
		e.preventDefault();
		if($('body').data('inline-html-call-counter') === undefined)
			$('body').data('inline-html-call-counter', 0);
		$('body').data('inline-html-call-counter', $('body').data('inline-html-call-counter') + 1);
		blockid = $('body').data('inline-html-call-counter');
		$('body').append('<div id="inline-html-call-block'+blockid+'" class="hidden inline-html-call-modal"></div>');
		$("#inline-html-call-block"+blockid).load($(this).attr('href'), function(){			       
			var dialog = bootbox.dialog({
		    message: $(this).html(),
		    backdrop: true,
		    onEscape: function() { $('.inline-html-call-modal').remove(); },
	      size: 'large'
			}).on('shown.bs.modal',function(){
			  $(this).find('[autofocus]').focus();
			});
			$(this).remove();
			// if any remote link clicked, make the progress bar bound to the model
			$('.bootbox.modal .modal-body a[data-remote]').click(function(e) {
				NProgress.configure({
					parent: '.bootbox.modal .modal-body',
					template: '<div class="bar" role="bar"><div class="peg"></div></div><div class="spinner-left" role="spinner"><div class="spinner-icon"></div></div>'
				});
				// on ajax complete reset the progress bar boundaries
				$(this).bind('ajax:complete', function(){ NProgress.configure({parent: 'body'}); });
			});
		});
	});
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
