(function(){
	if(bootbox !== undefined) {
		//Override the default confirm dialog by rails
		$.rails.allowAction = function(link){
		  if (link.data("confirm") == undefined){
		    return true;
		  }
		  $.rails.showConfirmationDialog(link);
		  return false;
		};
		//User click confirm button
		$.rails.confirmed = function(link){
		  link.data("confirm", null);
		  link.trigger("click.rails");
		};
		//Display the confirmation dialog
		$.rails.showConfirmationDialog = function(link){
			
			var dialog = link.data('confirm');
		  
			if(typeof link.data('confirm') === 'string')
				dialog = { message: link.data('confirm') };
			
			opt = Object.assign({
		    closeButton: false,
		    buttons: {
	        confirm: {
	            label: '<i class="fa fa-check"></i> تایید',
	            className: 'btn-success pull-right'
	        },
	        cancel: {
	            label: '<i class="fa fa-times"></i> انصراف',
	            className: 'btn-danger'
	        }
		    },
		    backdrop: true,
		    callback: function (confirmed) {
					if(confirmed)
		    		$.rails.confirmed(link);
		    }
			}, Object.assign({title: '', message: 'no `:message` input'}, dialog));
		  
		  if(opt.title !== undefined && opt.title.length !== 0)
		  	opt.title = '<b>' + opt.title + '</b>';
		  
			bootbox.confirm(opt);
		};
	}
})(jQuery);
