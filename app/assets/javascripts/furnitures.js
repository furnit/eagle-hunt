//= require jquery-ui

$(document).ready(function(){
  $('#cover-options [role=toolbar] .btn').click(function(){
    $('#cover-options > #cover-options-controls').toggleClass('hidden');
  });
  $('div#cover-img').backgroundDraggable({ axis: 'y', bound: true });
});
