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

$(document).ready(function(){
	$('a[data-toggle="tab"]').on('show.bs.tab', function(e) {
		if($(e.target).attr('aria-controls') === "confirm-tab-content") {
			$("#confirmation-content").html('');
			setTimeout(function() { fetch_edited_items(); }, 500);
		}
	});
	setTimeout(function() { 
		$('a[data-toggle="tab"]:last').click();
	}, 500);
});
function fetch_edited_items() {
	console.clear();
	sections = new Set();
	subsections = new Set();
	edited_class = ".label-warning";
	if($(edited_class).length === 0)
		$('.label-success:first').removeClass('label-success').addClass(edited_class.substr(1));
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
		$("#confirmation-content-confirm-action").addClass('hidden');
	}
	$('#confirmation-content-confirm-action').off('click.submit').on('click.submit', function(){
		if($(this).hasClass('disabled')) return;
		$(this).addClass('disabled');
		$(this).removeClass('btn-success').addClass('btn-warning');
		create_editable($('#confirmation-content ' + edited_class));
		$('#confirmation-content .editable').hide();
		// cover select types
		$('#confirmation-content .editable[data-type="select"]').each(function(){
			$(this).data('value', $(this).find('.fa-check').length);
		});
		$('#confirmation-content .editable').each(function(){
			// a workaround for issue [github: vitalets/x-editable/issues/997]
			$(this).editable({
				savenochange: true,
				url: $(this).attr('data-url-x'),
	  		// inject parameters to params sending to server
	  		params: function(params){	
	  			var hash = Object();
	  			$el = $(".value[data-pk='"+params.pk+"']");
	  			hash[$el.data('resource') + "[" + params.name + "]"] = params.value;
	  			return $.extend(hash, $el.data('options'));
	  		},
  		}).editable('submit').remove();
		});
		$(this).removeClass('disabled');
	}).click();
};
