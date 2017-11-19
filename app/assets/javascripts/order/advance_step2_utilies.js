//= require three.js/three.min
//= require three.js/OBJLoader
//= require three.js/TrackballControls
//= require three.js/webgl_detector
//= require three.js/init_scene
//= require three.js/load_objects
//= require three.js/THREEx.FullScreen

var selected_models = { };

function filter_availables() {
	if($("#only-show-availables").prop('checked')) {
		$('#step2-2-content .not-available').hide();
		// exculde it from photo-gallery
		$('#step2-2-content .not-available [data-type="photo-gallery"]')
			.removeAttr('data-type')
			.attr('xdata-type', 'photo-gallery');
	}
	else {
		$('#step2-2-content .not-available').show();
		// include it from photo-gallery
		$('#step2-2-content .not-available [xdata-type="photo-gallery"]')
			.removeAttr('xdata-type')
			.attr('data-type', 'photo-gallery');
	}
};
function reset_everything() {
	$("#step2-2-content").html("");
	$("#step2-2-helper").removeClass('hidden');
	$(".color-box.active").removeClass('active');
	$('#fabric-quality').prop('selectedIndex',0);
};

function show_selected_model(stage_id, model_id, model_name, model_price, model_quality, model_img) {
		var stages = $("#selection-stages tr.main-row");
		var sid = $(stages[stage_id]).attr('data-sid');
		var find_piece = function(sid, flag) { return $('[data-sid="'+sid.toString()+'"].selected-fabric-details' + flag); };

		// store the selected model into a variable
		selected_models[stage_id] = { sec_id: sid, model_id: model_id };

		find_piece(sid, '.model-name td:first').html('<strong>نام:</strong> ' + model_name);
		find_piece(sid, '.model-price td:first').html('<strong>قیمت:</strong> ' + model_price);
		find_piece(sid, '.model-quality td:first').html('<strong>کیفیت:</strong> ' +  model_quality);
		$('[data-sid="' + sid.toString() + '"] .selected-fabric-details.model-img img').attr('src', model_img);
		// show the items
		find_piece(sid, '.hidden').removeClass('hidden');
		$('[data-sid="' + sid.toString() + '"] .selected-fabric-details.hidden').removeClass('hidden');
		$('#step-nav .btn-next[disabled]').removeAttr('disabled');
		$(stages[stage_id]).attr('data-selected', 1);
		// flag the progress
		$("#selection-progress [data-sid='" + sid.toString() + "']")
			.removeClass('text-disabled')
			.addClass('text-success')
				.find('.fa')
					.attr('class', 'fa fa-check-square-o')
			.closest('li')
				.next('li')
					.removeClass('text-disabled');
		// set the selected texture to the view
		var texture   =  model_img;
		var show_case = $('[data-sid="'+sid.toString()+'"] .selected-fabric-details.model-img').attr('data-show-case');
		texture_select(show_case, texture);
		if(show_case === "ziri")
			texture_select("frame", texture);
}

function after_models_loaded() {
	$('.fab-container .select-fabric').click(function(){
		$(this).blur();

		$('.fab-container .select-fabric.selected').each(function() {
			$(this)
				.html($(this).attr('data-origin-text'))
				.removeClass('selected')
				.closest('.thumbnail')
					.css('box-shadow', 'unset');
		});

		$(this)
			.attr('data-origin-text', $(this).html())
			.html('<span class="fa fa-check"></span> انتخاب شد!')
			.addClass('selected')
			.closest('.thumbnail')
				.css('box-shadow', '0 0 10px green');

		var model = $(this).closest('.model[model-id]');
		var model_id = model.attr('model-id');
		var model_name = model.find('.model-name').text();
		var model_price = model.find('.model-price').text();
		var model_quality = model.find('.model-quality').text();
		var model_img = model.find('.img').attr('src');
		var stage_id = get_stage_id();

		show_selected_model(stage_id, model_id, model_name, model_price, model_quality, model_img);
	});
};
function load_fabrics(_url, _data) {
	// clear the content
  $("#step2-2-content").html("");
	$('#step2-2-helper').addClass('hidden');
	$("#step2-2-content").html("<div class='text-center'><span class='fa fa-spinner fa-spin'></span></div>");
	$.ajax({
		url: _url,
		data: _data,
		method: 'post',
		success: function(data) {
			// clear the content
		  $("#step2-2-content").html("");
		  // if nothing exists?
			if(data[0].meta.total_size == 0) {
				$("#step2-2-content").html("<div class='text-center'><span class='fa fa-exclamation-triangle'></span> هیچ پارچه‌ای با این کیفیت در سیستم ثبت نشده است.</div>");
				return;
			}
			$('.step2-2-options .filters').removeClass('hidden');
			// starting from 1: skip the meta part
			for(var i = 1, c = 0, j = data.length; i < j; i ++) {
				 var fabric = data[i];
				 $("#step2-2-content").append("<legend>" + fabric.brand.name + "</legend>");
				 var models = fabric.models;

				 $("#step2-2-content").append("<div class='row'>");
	 			 if(!fabric.brand.available) {
	 				 $("#step2-2-content legend").last().addClass('not-available');
	 				 $("#step2-2-content .row").last().addClass('not-available');
	 			 }
				 for(var l = 0, k = models.length; l < k; l++, c++) {
				 		$("#step2-2-content .row").last().append("<div class='col-md-4 col-sm-6 col-xs-6 text-center fab-container'></div>");
				 		var $wrapper = $("#step2-2-content .row .fab-container").last();
				 		$wrapper.append($('#fabric-model-template').clone().removeAttr('id class'));
				 		$wrapper_box = $wrapper.find('.thumbnail');

						$wrapper_box.addClass('model').attr('model-id', models[l].id);

				 		$wrapper_box.prepend("<a href='" + models[l].origin + "' data-type='photo-gallery' data-index='" + c.toString() + "' data-thumb='" + models[l].thumb + "'>\
				 			<img src='" + models[l].thumb + "' data-origin-src='" + models[l].origin + "' class='img img-responsive img-thumbnail' />\
			 			");
				 		$wrapper_box
				 			.find('.model-name').html(models[l].name);
				 		$wrapper_box
				 			.find('.model-quality').html(fabric.quality.name);
				 		$wrapper_box
				 			.find('.model-price').html(fabric.price + " تومان");
				 		$wrapper_box.find('.model-status span.labelx')
				 			.html(fabric.brand.available ? 'موجود' : 'ناموجود')
				 			.addClass(fabric.brand.available ? 'text-success' : 'text-danger');
			 			if(!fabric.brand.available) {
			 				$wrapper_box.find('.actions').remove();
			 				$wrapper.addClass('not-available');
		 				}
				 };
			};
 		  // append the pagination
	 	  var meta = data[0].meta;
	 		// if we have more than one page
	 		if(meta.total_size / meta.per_page > 1) {
		 		// if we have more than on page?
		 		var max_page = Math.ceil(meta.total_size / meta.per_page);
		 		$("#step2-2-content").append("<div id='fabric-pagination' class='row'></div>");
		 		// next page btn
		 		if(meta.current_page < max_page)
		 		 	$("#step2-2-content #fabric-pagination").append("<div class='col-sm-4'><a href='#' class='pull-left btn btn-default btn-nav' id='fabric-next-page' data-page='" + (Number(meta.current_page) + 1).toString() + "'>موارد بعدی <span class='fa fa-arrow-left'></span></a></div>");
		   	else
		 	    $("#step2-2-content #fabric-pagination").append("<div class='col-sm-4'></div>");
		 		// page status report
		 		$("#step2-2-content #fabric-pagination").append("<div class='col-sm-4 text-center'><small class='text-disabled'>صفحه‌ی " + meta.current_page + " از " + max_page + " </small></div>");
		 		// prev page btn
		 		if(meta.current_page > 1)
		 		 	$("#step2-2-content #fabric-pagination").append("<div class='col-sm-4'><a href='#' class='pull-right btn btn-default btn-nav' id='fabric-prev-page' data-page='" + (Number(meta.current_page) - 1).toString() + "'><span class='fa fa-arrow-right'></span> موارد قبلی</a></div>");
		   	else
		 	    $("#step2-2-content #fabric-pagination").append("<div class='col-sm-4'></div>");
		 	  // bind event for pagination
		 		$("#step2-2-content #fabric-pagination .btn-nav[data-page]").click(function() {
		 		 	// append the demaned page#
		 		 	_data["page"] = $(this).data("page");
		 		 	// first scroll to the position
		 		 	scroll_to("#step2-2-content", function() {
						// load fabrics
		 	 		 	load_fabrics(_url, _data);
		 	 	 	});
		 		});
	 		}
			filter_availables();
			after_models_loaded();
			execute_photo_gallery();
			// highlight and scroll-to the viewing image
			$("[data-type='photo-gallery']").click(function() {
				$('.fab-container.active').removeClass('active');
				scroll_to($(this).closest('.fab-container')).addClass('active');
				setTimeout(function(){
					gallery.listen('afterChange', function() {
						$('.fab-container.active').removeClass('active');
						var $container = scroll_to($(gallery.items[gallery.getCurrentIndex()].item).closest('.fab-container')).addClass('active');
						setTimeout(function() { $container.removeClass('active'); }, 3000);
					});
				}, 500);
			});
		}
	});
};

/* ANIMATIONS */

function reset_camera(graphic) {
	graphic.controls.reset();
	graphic.camera.position.set(3, 4, 10);
}
function display(loaded_models){
	if(typeof loaded_models === "undefined") {
		alert("Models has not been loaded yet....\nTry Later!");
		return;
	}
	$('#furniture-simulation').html("");
  graphic = init_scene(document.getElementById('furniture-simulation'));
	reset_camera(graphic);
	objects = loaded_models;
	for (var key in loaded_models) graphic.scene.add(loaded_models[key]);
  var animate = function() {
    requestAnimationFrame( animate );
    graphic.controls.update();
    graphic.renderer.render( graphic.scene, graphic.camera );
  };
  animate();
}
function texture_select(position, src) {
	set_texture(objects[position], load_texture(src));
}

/* UTILITIES */

function scroll_to(item, callback) {
	// return if no `item` exists
	if($(item).length === 0) return;
	$('html, body').animate({
  	scrollTop: $(item).offset().top - 70
 	}, 750, callback);
	return $(item);
}

function get_stage_id() {
	return $("#selection-stages").data('stage');
}

function set_stage_id(id) {
	$("#selection-stages").data('stage', id);
}
function remove_selected_model_flags() {
	$('.fab-container .select-fabric.selected').each(function(){
		$(this)
			.html($(this).attr('data-origin-text'))
			.removeClass('selected')
			.closest('.thumbnail')
				.css('box-shadow', 'unset');
	});
};
function active_stage($stage) {
	if($("#step2-2-content").html().length === 0)
		$("#step2-2-helper").removeClass('hidden');
	$("#selection-stages tr.main-row.active").removeClass('active');
	$stage
		.addClass('active')
		.unbind('click.reactivate')
		.find('.fa')
			.attr('class', 'fa fa-chevron-left');
	$("#selection-stages [data-sid='" + $stage.attr('data-sid') + "']")
		.removeClass('completed')
		.unbind('mouseenter mouseleave');
	set_stage_id($("#selection-stages tr.main-row").index($stage));
}
function complete_stage($stage) {
	$stage
		.removeClass('reactivated')
		.addClass('completed')
		.bind('click.reactivate', function() {
			remove_selected_model_flags();
			$("#selection-stages tr.main-row.reactivated").each(function() {
				complete_stage($(this));
			});
			$("#step2-2-post-final-step").addClass('hidden');
			$("#selection-stages tr.main-row .fa-chevron-left").removeClass('fa-chevron-left');
			$(this).addClass('reactivated');
			active_stage($(this));

			if($(this).attr('data-selected'))
				$("#step-nav .btn-next").removeAttr('disabled');
		})
		.find('.fa')
			.attr('class', 'fa fa-check');
	$("#selection-stages [data-sid='" + $stage.attr('data-sid') + "']")
		.addClass('completed')
		.removeClass('active hovered')
		.hover(function() {
			$("#selection-stages [data-sid='" + $(this).attr('data-sid') + "'].completed").addClass('hovered');
		}, function() {
			$("#selection-stages [data-sid='" + $(this).attr('data-sid') + "'].completed").removeClass('hovered');
		});
}
function build_order_details_step2() {
	return {
		section_model: selected_models
	};
}