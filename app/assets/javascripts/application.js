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
  }, 1000);
}
