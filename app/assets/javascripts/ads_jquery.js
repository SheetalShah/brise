$(document).ready(function(){

  function ad_type_change(){
    if( $('#ad_ad_type').val() === 'Buy' )
    {	
	$('#checkoption').show();
    }
    else
    {
      $('#checkoption').hide();
    }
    return false;
  };

  ad_type_change();
  $('#ad_ad_type').change(function(e) {        // Button which will activate our modal
     ad_type_change();
  });

  $(this).find("section#comment").hide();
  $('a#commentslink').click(function(e) {
	$(this).closest('section#adlink').next().toggle();
  } );

  var showChar = 250;
    var ellipsestext = "...";
    var moretext = "Show more";
    var lesstext = "Show less";

    $('.more').each(function() {
        var content = $(this).html();
        if(content.length > showChar) {
            var c = content.substr(0, showChar);
            var h = content.substr(showChar-1, content.length - showChar);
            var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;</span>';
            $(this).html(html);
        }
 
    });
 
    $(".morelink").click(function(){
        if($(this).hasClass("less")) {
            $(this).removeClass("less");
            $(this).html(moretext);
        } else {
            $(this).addClass("less");
            $(this).html(lesstext);
        }
        $(this).parent().prev().toggle();
        $(this).prev().toggle();
        return false;
    });
    $("span.timeago").timeago();



    $('#help').hover(function() {        // Button which will activate our modal
      $('#modal').show();
    }, function(e) {        // Button which will activate our modal
	$('#modal').hide();
    });

    $('#help').keyup(function(e) {
      if(e.which===27){ $('#modal').hide(); } // 27 is the keycode for the Escape key
    });
   
});
