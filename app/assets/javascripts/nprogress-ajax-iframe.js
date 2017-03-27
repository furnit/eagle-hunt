jQuery(function() {
  document.NProgress = window.NProgress; 
  $(document)
    .ajaxStart(function(){ document.NProgress.start(); })
    .ajaxStop(function(){ document.NProgress.done(); });
});