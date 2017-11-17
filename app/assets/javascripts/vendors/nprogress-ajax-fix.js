jQuery(function() {
	// fail-safe
	if(typeof document.NProgress === "undefined") document.NProgress = window.NProgress;
  jQuery(document).on('ajaxStart', function(){ document.NProgress.start(); });
  jQuery(document).on('ajaxStop', function(){ document.NProgress.done(); });
});
