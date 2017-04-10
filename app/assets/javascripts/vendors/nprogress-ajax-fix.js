jQuery(function() {
  jQuery(document).on('ajaxStart', function() {
  	if(!document.NProgress.isStarted()) document.NProgress.start();
  });
  jQuery(document).on('ajaxStop',  function() {
    document.NProgress.done();
  });
});
