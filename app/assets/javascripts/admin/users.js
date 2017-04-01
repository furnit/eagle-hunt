//= require moment.min
//= require jalali.min

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

  $('.datetime').each(function() {
    $(this).html(jalali2str(toJalaali(moment($(this).html(), 'YYYY-MM-DD HH:mm:ss ZZ').toDate())));
  });
});
