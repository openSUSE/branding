$(document).ready(function(){
  $('#header img').css('top','-30px').animate({top: 5},500);
  $("#opensuse").css('opacity',0).delayedShow(300,800);
  $("#support").css('opacity',0).delayedShow(800,800);
  $("#build").css('opacity',0).delayedShow(1200,800);
  $("#fun").css('opacity',0).delayedShow(1800,800);
	//$("#header img").css('opacity',0).delayedShow(1800,2000);
	$("#button").css('opacity',0).delayedShow(4000,2000);
});


$.fn.delayedShow = function (delaytime,animtime) {

  return $(this).oneTime(delaytime,function () {
    $(this).animate({'opacity':1},animtime);
  });
}
