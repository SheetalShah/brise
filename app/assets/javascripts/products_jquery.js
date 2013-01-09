$(document).ready(function(){
  $(".brandcontent").hide();
  //toggle the componenet with class msg_body
  $(".brandheading").click(function()
  {
	$(this).next(".brandcontent").slideToggle(500);
	window.location = "/brand_products/" + $(this).attr('id');
  });
});
