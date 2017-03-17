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

$(document).ready(function(){
	// append CSRF token to headers of all ajax posts
	$.ajaxSetup({
	  headers: {
	    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
	  }
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
		$('body').append('<div id="inline-html-call-block'+$('body').data('inline-html-call-counter')+'" class="hidden inline-html-call-modal"></div>');
		$("#inline-html-call-block"+blockid).load($(this).attr('href')+".ajax", function(){			       
			var dialog = bootbox.dialog({
		    message: $(this).html(),
		    backdrop: true,
		    onEscape: function() { $('.inline-html-call-modal').remove(); },
	      size: 'large'
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
