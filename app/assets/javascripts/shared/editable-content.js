//= require moment.min
//= require jalali.min
//= require bootstrap-editable
//= require bootstrap-editable-rails

$(document).ready(function(){
  function jalali2str(date) {
    m = [
      'فروردین',
      'ادریبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند'
    ];
    return date.jd.toString() + ' ' + m[date.jm-1] + (date.jy == toJalaali(new Date()).jy ? '' : ' ' + date.jy.toString());
  }
  
  function on_ajax_success() {
    $('.datetime:not(.jalali)').each(function() {
      try { $(this).html(jalali2str(toJalaali(moment($(this).attr('data-date'), 'YYYY-MM-DD HH:mm:ss ZZ').toDate()))).addClass('jalali'); } catch(e) { }
    });
		if($.isFunction($.fn.editable)) {
	    $('.editable:not(.editabled)').editable({
	     validate: function(value) { if($.trim(value) == '') return 'نمی‌تواند خالی باشد!'; },
	     error: function(response, newValue) {
	        if(response.status === 500) {
	            return 'سرور با خطا مواجه شده است!';
	        } else if(response.status === 422) {
	          try {
	            // check if json?
	            errors = Object.values($.parseJSON(response.responseText));
	            if(errors.length == 1) return errors[0];
	            str = "<ol>";
	            for (var i = 0; i < errors.length; i++) str += "<li>"+errors[i].toString()+"</li>";
	            str += "</ol>";
	            return str;
	
	          } catch(e) {
	            // if not json? just return the text
	            return response.responseText;
	          }
	        }
	      }
	    }).editable('toggleDisabled').addClass('editabled');
    }

    $('.btn-edit-content').off('click.editable-content').on('click.editable-content', function() {
		  $(this).blur();
		  $('.editable').editable('toggleDisabled');
		  $(this).toggleClass('btn-danger btn-default');
		  $(this).closest('.edit-content').find('.text-muted').toggleClass('invisible');
		  if($(this).hasClass('btn-danger'))
		    $(this).html("<span class='fa fa-lock'></span> قفل ویرایش");
		  else
		    $(this).html($(this).attr('data-origin-text'));
    });
  }

  on_ajax_success();
  
  $(document).ajaxSuccess(on_ajax_success);
});
