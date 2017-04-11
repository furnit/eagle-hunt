jQuery(function() {
  jQuery(document).on('ajaxStart', function(){ document.NProgress.start(); });
  jQuery(document).on('ajaxStop', function(){ document.NProgress.done(); });
});
