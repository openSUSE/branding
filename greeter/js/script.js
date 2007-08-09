$(document).ready(function(){
	$("#header img").hide().fadeIn(3000);
	$("#button").hide();
	setTimeout("$(\"#button\").fadeIn(1000)", 2000);
	$("#button").click(function() {
		self.close();
	});
});



