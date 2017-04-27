
$(document).ready(function () {
	// un-blure nav step
	setTimeout(function() { $('.nav-step').blur().removeClass('disabled'); }, 2500);
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
  	var kill_editable = function() {
  		$('.furniture-intel .panel-edit').each(function() {
	  		if($(this).data('origin-html') !== undefined)
	  			$(this).html($(this).data('origin-html'));
  		});
  		$('.furniture-intel .editable').remove();
  		$('.furniture-intel .label').show();
		};
		if($(this).data('origin-html') === undefined)
			$(this).data('origin-html', $(this).html());
  	// check if enabling
  	if(enable) {
  		// kill all other editables
  		kill_editable();
  		$(this).html('<span class="fa fa-times"></span> پایان ویرایش');
  		// create `.editable`s on fly
	  	$(this).closest('.panel-body').find('.label').each(function() {
	  		if($(this).find('.value').length) {
		  		$(this).hide();
		  		value = $(this).find('.value').get(0);
		  		data_attr = [].filter.call(value.attributes, function(at) { return /^data-/.test(at.name); });
		  		link = "<a href='#' class='editable' ";
		  		// inject `data` attributes
		  		for(var i=0,j=data_attr.length; i<j; i++) { link += data_attr[i].name + "='" + data_attr[i].value + "' "; };
					link += " onclick='return false'>" + ($.isNumeric($(value).text().replace(/,/g, "")) ? parseFloat($(value).text().replace(/,/g, "")) : $(value).text()) + '</a>';
		  		$(this).closest('td').append(link);
  			}
	  	});
	  	// set arguments for created editables
	  	$('.panel-body .editable').editable({
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
	  			if($('.furniture-intel .editable.editable-open').data('type') == "select")
	  				if(newval == "0")
	  					val.find(".fa").attr('class', 'fa fa-times');
  					else
  						val.find(".fa").attr('class', 'fa fa-check');
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
});