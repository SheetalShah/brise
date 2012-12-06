$('.commentslink').ready(function(){
  $(".commentslink").click(function(){
        $(this).parent().parent().parent().next().children().toggle();
	return false;
    });
  $("span.timeago").timeago();
});
