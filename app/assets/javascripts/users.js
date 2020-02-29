document.addEventListener("turbolinks:load", function() {
	$('#user_avatar').change(function() {
	  var fr = new FileReader();
	  fr.onload = function() {
	    img_preview(fr, 0);
	  };
		fr.readAsDataURL(this.files[0]);
	});

	$('#user_bgimage').change(function() {
		  var fr = new FileReader();
		  fr.onload = function() {
		    img_preview(fr, 1);
		  };
			fr.readAsDataURL(this.files[0]);
		});


	$('.preview').bind('dragover', function (e) {
		e.stopPropagation();
		e.preventDefault();
		this.style.background = "#e6e6e6";
	}).bind('dragleave', function(e) {
		e.stopPropagation();
		e.preventDefault();
		this.style.background = "#fff";
	}).bind('drop', function(_e) {
		var e = _e;
    if (_e.originalEvent) {
      e = _e.originalEvent;
    }
		e.stopPropagation();
		e.preventDefault();
		this.style.background = "#fff";
		var files = e.dataTransfer.files;
		var index = $('.preview').index(this);
		if (index === 0) {
			var fileInput = document.getElementById('user_avatar')
		} else {
			var fileInput = document.getElementById('user_bgimage')
		}
    fileInput.files = files;
		var fr = new FileReader();
		fr.onload = function() {
			img_preview(fr, index);
		};
		if (index === 0) {
			fr.readAsDataURL(files[0]);
			$('#user_avatar').files = files;
		} else {
			fr.readAsDataURL(files[0]);
			$('#user_bgimage').files = files;
		}
	});

	var img_preview = function(fr, num) {
		$('.preview').eq(num).empty();
		var img = $('<img>').attr('src', fr.result);
		$('.preview').eq(num).append(img);
	}
});
