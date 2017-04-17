function notify_me_enable() {
	$('#notify-me-form .btn-submit').removeClass('disabled');
}
function notify_me_reset() {
	if(typeof grecaptcha === "object")
		// escape from `Invalid ReCAPTCHA client id: undefined`
		try { grecaptcha.reset(); } catch(e) { }
}
function notify_me_submit() {
	form = ('#notify-me-form form');
	$(form).find('.btn-submit').addClass('disabled');
	$(form).find('[name="checked"]').remove();
	$('<input>').attr({
	    type: 'hidden',
	    value: $('[name="notify-me"]').prop('checked'),
	    name: 'checked'
	}).prependTo(form);
	$(form).trigger('submit.rails');
}
function notify_me_open($this) {
	notify_me_reset();
	var $el = $this.addClass('open').closest('.block').find('.block-footer');
	$('#notify-me-form form .btn-submit')
		.find('[avail-checked]')
			.addClass('hidden')
		.closest('.btn-submit')
			.find('.fa')
				.attr('class', 'fa fa-'+($('[name="notify-me"]').prop('checked') ? 'check' : 'trash'))
		.closest('.btn-submit')
			.find('[avail-checked="'+ $('[name="notify-me"]').prop('checked')+'"]')
				.removeClass('hidden');
	
	$el.find('#sell-conditions').fadeOut(function(){
		$el.find('#notify-me-form').hide().removeClass('hidden').fadeIn();
	});
}
function notify_me_close($this) {
	var $el = $this.removeClass('open').closest('.block').find('.block-footer');
	$el.find('#notify-me-form').fadeOut(function(){
		$(this).removeClass('hidden');
		$el.find('#sell-conditions').fadeIn();
	});
}
$(document).ready(function(){
	$('[name="notify-me"]').change(function() {
		if($(this).hasClass('open')) notify_me_close($(this)); 
		else notify_me_open($(this));
	});
	$('#notify-me-form form')
		.on('ajax:error', function(e, data) {
			notify_me_reset();
			try {
				bootbox.alert({
					title: 'خطا در ثبت اطلاعات!',
					message: JSON.parse(data.responseText).message
				});
			// ignore exceptions of 50x server errors
			} catch(e) { }
		}).on('ajax:success', function(e, data){
			notify_me_reset();
			notify_me_close($('[name="notify-me"]'));
			bootbox.alert({ message: data.message });
		});
});