jQuery(function() {
  if ($('#infinite-scrolling').length > 0) {
    $(window).on('scroll', function() {
      var more_posts_url;
      more_posts_url = $('#infinite-scrolling .pagination .next a').attr('href');
      if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
        $('#infinite-scrolling .pagination').html('<span class="fa fa-spinner fa-spin"></span> بارگذاری ...');
        $.getScript(more_posts_url);
      }
    });
  }
});