function kill_editable() {
	$('.furniture-intel .panel-edit').each(function() {
		if($(this).data('origin-html') !== undefined)
			$(this).html($(this).data('origin-html'));
	});
	$('.furniture-intel .editable').remove();
	$('.furniture-intel .label').show();
};
function create_editable($this) {
	$this.find('.value').each(function() {
		value = $(this).get(0);
		data_attr = [].filter.call(value.attributes, function(at) { return /^data-/.test(at.name); });
		link = "<a href='#' class='editable' ";
		// inject `data` attributes
		for(var i=0,j=data_attr.length; i<j; i++) { link += data_attr[i].name + "='" + data_attr[i].value + "' "; };
		link += " onclick='return false'>" + ($.isNumeric($(value).text().replace(/,/g, "")) ? parseFloat($(value).text().replace(/,/g, "")) : $(value).text()) + '</a>';
		$(this).closest('td').append(link);
	});
	return $this;
}

$(document).ready(function () {
	// un-blure nav step
	setTimeout(function() { $('.nav-step').blur().removeClass('disabled'); }, 2500);
	// on tab changes
	$('a[data-toggle="tab"]').on('show.bs.tab', function(e) {
		// only do for furniture-intels
		if($(e.target).attr('for') === "furniture-intels")
			// reset editables and labels
			kill_editable();
	});
	// popover furniture section
	$('img.furniture-section').on('mouseover', function(e) {
		$(this).popover({
      html: true,
      trigger: 'hover',
      placement: 'bottom',
      content: function(){ return '<img src="'+$(this).attr('src') + '" />';}
    });
    $(this).popover('show');
  });
  // prettify data
  var editable_pretty_data = function(update) {
  	if(update === undefined) update = false;
	  $('.value[data-type="text"]:not(.currency)').each(function(){
	  	$(this).text(parseFloat($(this).text()));
	  });
	  $('.value.currency').each(function(){
	  	$(this).text(parseInt($(this).text().replace(/,/g, "")).toLocaleString());
	  	if(!update) $(this).attr('data-original-title', "مقدار اولیه: " + $(this).text());
	  	$(this).addClass('currencified');
	  });
  };
  // initialy make them pretty
  editable_pretty_data();
  // inline editable
  $('.furniture-intel .panel-edit').click(function() {
  	$(this).data('enabled', $(this).data('enabled') ? false : true);
  	enable = $(this).data('enabled');
		if($(this).data('origin-html') === undefined)
			$(this).data('origin-html', $(this).html());
  	// check if enabling
  	if(enable) {
  		// kill all other editables
  		kill_editable();
  		$(this).html('<span class="fa fa-times"></span> پایان ویرایش');
  		// create `.editable`s on fly and hide all related labels
			create_editable($(this).closest('.panel-body')).find('.label').hide();
	  	// set arguments for created editables
	  	$('.panel-body .editable').editable({
	  		// don't intialy disable the editables
	  		disabled: false,
	  		// inject parameters to params sending to server
	  		params: function(params){
	  			params = $.extend(params, $(".value[data-pk='"+params.pk+"']").data('options'));
	  			delete params.pk;
	  			return params;
	  		},
	  		// validate inputs
        validate: function(value) {
            if ($.isNumeric(value) == '') {
                return 'داده‌ها باید عدد باشند!';
            }
        },
        // on success submit operation
	  		success: function (response, newval) {
	  			// indicate the changes
	  			var val = $('.furniture-intel .editable.editable-open').siblings('.label').removeClass('label-success label-danger').addClass('label-warning').find('.value');
	  			if($('.furniture-intel .editable.editable-open').data('type') == "select") {
	  				var select = $.grep($(this).data('source'), function(e){ return e.value == newval; });
						$('.value[data-pk="' + $(this).data('pk') + '"]').attr('data-value', newval).text(select[0]["text"]);
	  			}
	  			else
	  				val.text(newval);
  				editable_pretty_data(true);
  				// a workaround for issue: [github: vitalets/x-editable/issues/996]
  				setTimeout(function() {
	  				if($('.furniture-intel .editable.editable-disabled').length)
	  					$('.furniture-intel .editable.editable-disabled').editable('toggleDisabled');
					}, 100);
	  		}
			});
			// inject the source of `select` editables 
			$('.furniture-intel .editable[data-type="select"]').each(function(){
				$(this).editable({
					source: $(this).data('source')
				});
			});
			// $('.furniture-intel .editable').editable('toggleDisabled');
		// if disabling the inline `editable`
  	} else {
  		kill_editable();
  	}
  });
  // highlighing
  $('.furniture-intel tr td').has('.label').hover(function(){
  	// disable this feature
  	return
  	row    = $(this).closest('tr');
  	column = $(this).closest('td');
  	if(column.has('.editable').length) return;
  	if($('tr[kid="' + row.attr('kid') + '"]').hasClass('divider')) {
  		if(row.hasClass('divider')) {
  			column.find('.label').addClass('kid-effect');
		  	$('tr[kid="' + row.attr('kid') + '"]').not(row).find('td:nth-child(' + (column.index()) + ') .label').addClass('kid-effect');
			} else {	
		  	$('tr[kid="' + row.attr('kid') + '"]').not('.divider').find('td:nth-child(' + (column.index() + 1) + ') .label').addClass('kid-effect');
		  	$('tr.divider[kid="' + row.attr('kid') + '"]').find('td:nth-child(' + (column.index() + 2) + ') .label').addClass('kid-effect');
			}
  	} else {
  		$('tr[kid="' + row.attr('kid') + '"] td:nth-child(' + (column.index() + 1) + ') .label').addClass('kid-effect');
  	}
  	$('.furniture-intel tr .label:not(.kid-effect)').css('opacity', 0.1);
  }, function(){
  	$('.furniture-intel tr .label').css('opacity', 1).removeClass('kid-effect');
  });
	$('a[data-toggle="tab"]').on('show.bs.tab', function(e) {
		if($(e.target).attr('aria-controls') === "confirm-tab-content") {
			$("#confirmation-content").html('');
			if($('#confirmation-content-confirm-action').data('origin-html') === undefined)
				$('#confirmation-content-confirm-action').data('origin-html', $('#confirmation-content-confirm-action').html());
			$('#confirmation-content-confirm-action').html($('#confirmation-content-confirm-action').data('origin-html'));
			setTimeout(function() { fetch_edited_items(); }, 500);
		}
	});
});

function fetch_edited_items() {
	sections = new Set();
	subsections = new Set();
	edited_class = ".label-warning";
	confirmed_class = ".label-success";
	$(edited_class + ' .value').each(function() {
		sec = $(this).closest('.furniture-intel').find('legend').wrap('<p/>').parent().html();
		var c = $(this).closest('.panel').clone();
		if(!sections.has(sec)) {
			sections.add(sec);
			$('#confirmation-content').append(sec);
		}
		if(!subsections.has(sec + c.find('.panel-heading').text())) {
			subsections.add(sec + c.find('.panel-heading').text());
			c.find('.panel-edit').remove();
			c.find('.label:not(' + edited_class + ')').removeClass('label label-success label-danger');
			$('#confirmation-content').append(c);
			$("#confirmation-content-confirm-action").removeClass('hidden');
		}
	});
	if($(edited_class + ' .value').length == 0 && !$("#confirmation-content").has(".empty-collection").length) {
		$('#confirmation-content').prepend('<div class="empty-collection">تغییری در داده‌ها صورت نگرفته است و تایید داده‌ها بلامانع است.</div>');
		// no need for two-step-auth for no-change-confirmation
		$("#two-step-auth-container").addClass('hidden');
	} else {
		// enable two-step-auth if any change applied
		$("#two-step-auth-container:not([ignore-at-initial])").removeClass('hidden');
	}
	var confirm_content_action = function() {
		$('#confirmation-content-confirm-action').off('click.submit');
		$(this).addClass('disabled');
		$("#confirm-submit-container .panel-errors ol").html('').closest('.panel-errors').hide().removeClass('hidden');
		create_editable($('#confirmation-content ' + edited_class));
		$('#confirmation-content .editable').hide();
		// cover select types
		error_flag = false;
		$('#confirmation-content .editable').each(function(index){
			if(error_flag) return;
			$('#confirmation-content-confirm-action').attr('class', 'btn btn-default').html('<span class=\'fa fa-spinner fa-spin\'></span> در حال ثبت اطلاعات (داده‌ی باقی‌مانده: ' + ($('#confirmation-content .editable').length - (index + 1)) + ')');
			// a workaround for issue [github: vitalets/x-editable/issues/997]
			$(this).editable({
				savenochange: true,
				url: $(this).attr('data-url-x'),
	  		// inject parameters to params sending to server
	  		params: function(params){	
	  			var hash = Object();
	  			var $el = $(".value[data-pk='"+params.pk+"']");
	  			hash[$el.data('resource') + "[" + params.name + "]"] = params.value;
	  			// pass the temp token password
	  			var $token_input = $('#two-step-auth-container input[name]:first');
	  			hash[$token_input.attr('name')] = $token_input.val();
	  			return $.extend(hash, $el.data('options'));
	  		},
	  		success: function() {
	  			var $el = $(this);
	  			$el.addClass('confirmed');
	  			var $parent = $el.closest('td');
	  			// flag the edited item in `current tab` to `confirmed` 
	  			$parent.find(edited_class).removeClass(edited_class.substr(1)).addClass(confirmed_class.substr(1));
	  			// notify with a check
	  			$parent.append("<span class='fa fa-check text-success'></span>");
	  			// flag the item in its origin tab as `confirmed`
	  			$('.furniture-intel ' + edited_class).has('[data-pk="'+$(this).data('pk')+'"]').removeClass(edited_class.substr(1)).addClass(confirmed_class.substr(1));
	  		},
	  		error: function(data) {
	  			try {
	  				info = JSON.parse(data.responseText);
	  				if(info.cause === "two_step_auth")
	  					$("#two-step-auth-container").removeClass('hidden').find('.input-group').addClass('has-error');
	  				$("#confirm-submit-container .panel-errors ol").append("<li class='text-danger'>" + info.message + "</li>").closest('.panel-errors').slideDown();
	  			} catch (e) { }
	  			error_flag |= true; $('#confirmation-content .editable').addClass('confirmed');
  			}
  		}).editable('submit');
		});
		wait2confirm_all = setInterval(function($this) {
			if($('#confirmation-content .editable:not(.confirmed)').length > 0) return;
			$('#confirmation-content .editable').remove();
			if(error_flag) {
				$('#confirmation-content-confirm-action').html($('#confirmation-content-confirm-action').data('origin-html'));
				$this.attr('class', 'btn btn-primary');
			} else {
				$this.html("<span class='fa fa-spinner fa-spin'></span> در حال نهایی‌سازی تایید اطلاعات.");
				$this.attr('class', 'btn btn-success');
				data = { };
				$('.confirm-intel-editional-data input[type="checkbox"][name]').each(function() { data[$(this).attr('name')] = $(this).is(':checked'); });
				$.ajax({
					url: $('input.furniture-intel[type="hidden"][name="flink"]').val(),
					type: 'POST',
					data: data,
					success: function(data) {
						if(data.status === "success") {
							$this.html("<span class='fa fa-check'></span> اطلاعات با موفقیت تایید و در سامانه ثبت شد.");
							setTimeout(function() { $this.closest('.modal').modal('hide'); setTimeout(function(){ window.location.reload(); }, 500); }, 1000);
						}
						else {
							$this.html("<span class='fa fa-times'></span> خطا در تایید نهایی محصول.");
							$("#confirm-submit-container .panel-errors ol").append("خطا در تایید نهایی محصول.").closest('.panel-errors').slideDown();;
						}
					},
					error: function() {
						$this.html("<span class='fa fa-times'></span> خطا در تایید نهایی محصول.").attr('class', 'btn btn-danger');
						$("#confirm-submit-container .panel-errors ol").append("خطا در تایید نهایی محصول.").closest('.panel-errors').slideDown();;
					}
				});
			}
			clearInterval(wait2confirm_all);
		}, 300, $(this));
		$(this).removeClass('disabled');
		$('#confirmation-content-confirm-action').on('click.submit', confirm_content_action);
	};
	$('#confirmation-content-confirm-action').off('click.submit').on('click.submit', confirm_content_action);
};
