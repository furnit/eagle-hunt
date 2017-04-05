jQuery(function() {
  document.NProgress = window.NProgress; 
  $(document)
    .ajaxStart(function(){ document.NProgress.start(); })
    .ajaxStop(function(){ document.NProgress.done(); })
    .ajaxComplete(function(){ document.NProgress.done(); });
});