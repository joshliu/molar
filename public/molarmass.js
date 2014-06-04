$(document).ready(function() {
	$('#head').addClass('animated bounceInDown');
	$('#head').mouseenter(function() {
		$('#head').fadeTo('fast', 0.25);
	});

	$('#head').mouseleave(function() {
		$('#head').fadeTo('fast', 1);
	});
});
