$(document).ready(function(){
	$("#header img").fadeIn("slow");
	//setTimeout("$(\"#button\").fadeIn(1000)", 2000);
	$("#button").click(function() {
		console.log("clicked");
		self.close();
	});
});



