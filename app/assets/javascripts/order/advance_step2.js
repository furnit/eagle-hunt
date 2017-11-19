//= require order/advance_step2_utilies

$(document).ready(function() {
	var move_on_next_step = false;
	// init the page
	$("#step-nav .btn-next").attr('disabled', 'disabled');
	$("#step2 #selection-progress li:first").removeClass('text-disabled');
	if($("#selection-stages tr.main-row:last").hasClass('completed'))
		$("#step2-2-post-final-step").removeClass('hidden');
	else
		$("#step2-2-post-final-step").addClass('hidden');
	if(typeof $("#selection-stages").data('stage') === "undefined")
		$("#selection-stages").data('stage', 0);

	// try to load the models first
	load_objects(models, function(loaded_models) {
		display(loaded_models);
		after_graphics_loaded();
	});

	// activate the first stage
	active_stage($($("#selection-stages tr.main-row").get($("#selection-stages").data('stage'))));

	// reset the camera position
	$("#furniture-simulation-reset").click(function() {
		$(this).blur();
		reset_camera(graphic);
	});

	// make simulation full-screen
	$("#furniture-simulation-fullscreen").click(function() {
		$(this).blur();
		if(!THREEx.FullScreen.available()) {
			bootbox.alert('مرورگر شما امکان بزرگ‌نمایی ندارد، لطفا مرورگر‌ خود را بروز رسانی کنید یا از مرورگر‌های مدرن استفاده کنید.');
			$(this).attr('disabled', 'disabled');
			return;
		}
		// store the default renderer size
		if(typeof graphic.renderer.domElement.default_size === "undefined")
			graphic.renderer.domElement.default_size = [graphic.renderer.domElement.style.width, graphic.renderer.domElement.style.height].map(function(item) { return item.replace("px", ""); });
		// request the fullscreen
		THREEx.FullScreen.request(graphic.renderer.domElement);
		// set the render to fullsize
		graphic.renderer.setSize(window.screen.width, window.screen.height);
		// list the fullscreen event listening events
		var fullscreen_events = [
			'webkitfullscreenchange',
			'mozfullscreenchange',
			'fullscreenchange',
			'MSFullscreenChange'
		];
		// foreach event
		fullscreen_events.forEach(function(trigger) {
			// event function
			var fs_event = function() {
				// if fullscreen exiting?
		    if (!(document.webkitIsFullScreen || document.mozFullScreen || document.msFullscreenElement)) {
		    	// remove the event function
		  		document.removeEventListener(trigger, fs_event, true);
		  		var wh = graphic.renderer.domElement.default_size;
		  		// reset the renderer size to its default
  		  	graphic.renderer.setSize(wh[0], wh[1]);
		    }
			};
			// bind the event
	    document.addEventListener(trigger, fs_event, false);
		});
	});

	// step2 local navigations
	$("#step-nav .btn-next").click(function() {
		var stages = $("#selection-stages tr.main-row");
		var stage_id = get_stage_id();
		// complete the current stage
		complete_stage($(stages[stage_id]));
		// check if reached to the final stage
		if(stages.length === stage_id + 1) {
			if(move_on_next_step)
				next_step();
			return;
		}
		// activate the next stage
		active_stage($(stages[stage_id + 1]));
	});
	$("#step-nav .btn-prev").click(function() {
		var stages = $("#selection-stages tr.main-row");
		var stage_id = get_stage_id();
		// check if reached to the initial stage
		if(stage_id <= 0) {
			prev_step();
			return;
		}
		move_on_next_step = false;
		// activate the previous stage
		active_stage($(stages[stage_id - 1]));
	});

	$("#step-nav .btn").click(function() {
		$(this).blur();
		scroll_to($("#step2"));
		var stages = $("#selection-stages tr.main-row");
		var stage_id = get_stage_id();
		if($(stages[stage_id]).attr('data-selected'))
			$("#step-nav .btn-next").removeAttr('disabled');
		else
			$("#step-nav .btn-next").attr('disabled', 'disabled');

		// check if reached to the final stage
		if($("#selection-stages tr.main-row:last").hasClass('completed')) {
			// flag all the stages completed
			$("#selection-stages tr.main-row").each(function() { complete_stage($(this)); });
			if($(this).hasClass('btn-next')) {
				reset_everything();
				$("#step2-2-helper").addClass('hidden');
				$("#step2-2-post-final-step").removeClass('hidden');
				// make the .btn-next to move on to the next step
				move_on_next_step = true;
				// do not proceed
				return;
			} else {
				// if prev btn?
				// activate the last stage
				active_stage($(stages[stages.length - 1]));
			}
		}

		$("#step2-2-post-final-step").addClass('hidden');
		remove_selected_model_flags();
	});

	// filter controls
	$("#only-show-availables").click(filter_availables);
	$('#fabric-quality').change(function() {
		if($("#selection-stages tr.main-row.active").length === 0) return;
		// if blank value selected?
		if($(this).find('[value=""]:selected').length > 0) return;
		$(this).blur();
		load_fabrics(ls_fabrics_api_path, {q: $(this).find(':selected').val()});
		$('.color-box.active').removeClass('active');
	});
	$('.color-box[data-id]').click(function() {
		if($("#selection-stages tr.main-row.active").length === 0) return;
		$('.color-box.active').removeClass('active');
		$(this).addClass('active');
		load_fabrics(ls_fabric_models_api_path, {cc: $(this).data('id')});
	});
});