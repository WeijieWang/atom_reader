var pageRefresh = function() {
	alert("This is under construction!");
};

var previousEntry = function() {
	var entry = $('.wrapped-entry').first(), margin = 20, 
	distance = 0, d = entry.offset().top;
	while (!((d <= 80) && (d > -(entry.height() - 80)))) {
		distance += entry.height() + margin;
		entry = entry.next();
		d = entry.offset().top;
	}
	distance = distance - (entry.prev().height() + margin);
	$('#right-part').scrollTop(distance);
};

var nextEntry = function() {
	var entry = $('.wrapped-entry').first(), margin = 20, 
	distance = entry.height() + margin, d = entry.offset().top;
	while (!((d <= 80) && (d > -(entry.height() - 80)))) {
		entry = entry.next();
		d = entry.offset().top;
		distance += entry.height() + margin;
	}
	$('#right-part').scrollTop(distance);
};

$(document).ready(function() {

	$('#refresh-button').on('click', pageRefresh);
	$('#next-button').on('click', nextEntry);
	$('#previous-button').on('click', previousEntry);

});
