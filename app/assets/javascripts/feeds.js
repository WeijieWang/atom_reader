$(document).ready(function() {
	var pageAlert = function() {
		alert("This is working");
	};

	$('#refresh-button').on('click', pageAlert);

});
