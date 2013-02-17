$(document).ready(function(){
  $('#send-query').click(function() {        // Button which will activate our modal
   $("div#send-queryform").dialog('open' );
});

$('#cancel-query').click(function() {
  $("div#send-queryform").dialog('close');
});

$( "#send-queryform" ).dialog({
autoOpen: false,
closeText: '',
modal: true,
width: 450,
height: 600,
});


$('.best_in_place').bind("ajax:success", function () {$(this).closest('tr').effect('highlight'); });
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
  $(".contact-card").each(function(){
   var _this = $(this);
   _this.hovercard({        
        detailsHTML: $("div[data-id=" + $(this).attr('data-id')+ "]").attr('data-image-html'),
        width: 300,
        cardImgSrc: $("div[data-id=" + $(this).attr('data-id') + "]").attr('data-image-url'),
   });
});

/*
  $('img').hover(function() {
// hover over
			var $this = $(this);
			$this.parent().css('z-index',200);
			
			//var size = $this.data('hoverpulse.size');
			var w = 200, h = 200;
			$this.animate({ 
				top:  '-20px', 
				left: '-20px', 
				height: '200px', 
				width:	'200px' 
			}, 200);
		},
		// hover out
		function() {
			var $this = $(this);
//			var size = $this.data('hoverpulse.size');
			var w = 200, h = 200;
			
			$this.animate({ 
				top:  0, 
				left: 0, 
				height: '100px', 
				width:	'100px' 
			}, 200, function() {
				$this.parent().css('z-index', 1);
			});
		}
    
  );
*/
  user_type_change();
  $('#user_user_type').change(function(e) {        // Button which will activate our modal
     user_type_change();
  });

 $(document).click(function() {
 });

 $('a').click(function() {
   $("div#mapmodal").dialog('close');
 });

  $('section#maphelp').click(function() {        // Button which will activate our modal
   $("div#mapmodal").dialog('open');
   var width = 400;
   var height = 430;
    var posX = $(this).position().left - $(document).scrollLeft() + $(this).outerWidth();
   var posY = $(this).position().top - $(document).scrollTop() + $(this).outerHeight();
   $("div#mapmodal").dialog({width:width, height:height ,position:[posX, posY], closeText: '',});
   Gmaps.loadMaps();
});

  $('.close').click(function(){  $("div#mapmodal").dialog('close'); });
});
