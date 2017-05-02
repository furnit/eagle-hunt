$(document).ready(function(){ wizard_tabline(); });

function wizard_tabline() {
  //Initialize tooltips
  $('.wizard-tabs .nav-tabs > li a[title]').tooltip();

  //wizard-tabs
  $('.wizard-tabs a[data-toggle="tab"]').on('show.bs.tab', function(e) {
    var $target = $(e.target);
    if ($target.parent().hasClass('disabled')) {
      return false;
    }
  });
  
  $(".next-step").off('click.tablinified').on('click.tablinified', function() { wizard_tabline_next_step(); });
  
  $(".prev-step").off('click.tablinified').on('click.tablinified', function() { wizard_tabline_prev_step(); });
};

function wizard_tabline_next_step() {
  var $active = $('.wizard-tabs .nav-tabs li.active');
  $active.next().removeClass('disabled');
  wizard_tabline_nextTab($active);
}

function wizard_tabline_prev_step() {
  var $active = $('.wizard-tabs .nav-tabs li.active');
  wizard_tabline_prevTab($active);
}

function wizard_tabline_nextTab(elem) {
  $(elem).next().find('a[data-toggle="tab"]').click();
}

function wizard_tabline_prevTab(elem) {
  $(elem).prev().find('a[data-toggle="tab"]').click();
}