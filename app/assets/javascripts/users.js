$(document).ready(function(){
  function user_type_change(){
    if( $('#user_user_type').val() == 'company' )
    {	
	$(".hidden_option").fadeIn('fast');   
    }
    else
    {
      $(".hidden_option").fadeOut('fast');
    }
    return false;
  };

  user_type_change();
  $('#user_user_type').change(function(e) {        // Button which will activate our modal
     user_type_change();
  });

 $(document).click(function() {
   $("div#modal").dialog('close');
   $("div#mapmodal").dialog('close');
 });

 $('a').click(function() {
   $("div#modal").dialog('close');
   $("div#mapmodal").dialog('close');
 });


 $('section#help').hover(function() {        // Button which will activate our modal
   id = $(this).attr('data-id');
   $("div#modal").dialog('close');
   var width = 250;
   var height = 270;
$("div[data-id=" + id + "]").dialog('open');
   elem = $("section[data-id=" + id + "]");
   var posX = elem.offset().left - $(document).scrollLeft() - width + $(this).outerWidth();
   var posY = elem.offset().top - $(document).scrollTop() + $(this).outerHeight();
   $("div[data-id=" + id + "]").dialog({width:width, height:height ,position:[posX, posY], closeText: '',});
      return false;
    });

  $('section#maphelp').click(function() {        // Button which will activate our modal
   $("div#modal").dialog('close');
   $("div#mapmodal").dialog('close');
   var width = 200;
   var height = 200;
   $("div#mapmodal").dialog('open');
   var posX = $(this).offset().left - $(document).scrollLeft() - width + $(this).outerWidth();
   var posY = $(this).offset().top - $(document).scrollTop() + $(this).outerHeight();
   $("div#mapmodal").dialog({width:width, height:height ,position:[posX, posY], closeText: '',});
   Gmaps.loadMaps();
   return false;
  });

  $('.close').click(function(){  $(this).dialog('close'); });
});
