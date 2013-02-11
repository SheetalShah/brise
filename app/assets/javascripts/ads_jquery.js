$(document).ready(function(){
/*
  $('img').mouseover(function() {
// hover over

alert("hover in");
			
    var $this = $(this);
    $this.parent().css('z-index',200);
	alert('200');		
			//var size = $this.data('hoverpulse.size');
			var w = 200, h = 200;
			$this.animate({ 
				top:  '-20px',
				left: '-20px',
				height: '200px', 
				width:	'200px' 
			}, 200);
  });
*/
   Gmaps.loadMaps();
/*
  function input_price_change(){
    if( $("input#remove:checkbox:checked").val() == undefined )
    {
       $("input#comment_indicative_price_cents").attr( "disabled", true );
    }
    else
    {
       $("input#comment_indicative_price_cents").attr( "disabled", false );
    }
  };*/
function input_price_best_change(){
    if( $("input#ad_price_eval:checkbox:checked").val() == undefined )
    {
       $(".priceinputs").show();
    }
    else
    {
       $(".priceinputs").hide();
    }
  };

  $(".onfocuscommentitems").hide();
  $("textarea#comment_description").focus(function() {

     $(".onfocuscommentitems").show();
  } );
  input_price_best_change();
//  input_price_change();
  input_address_zip_change();
  $("#remove").click(function(){
    input_price_change();
  });

  $("input#ad_price_eval").click(function(){
    input_price_best_change();
  });
function input_address_zip_change(){

    if( $("input#ad_use_address_zip_code:checkbox:checked").val() == undefined )
    {
       $(".zipinput").show();
    }
    else
    {
       $(".zipinput").hide();
    }
  };


  $("input#ad_use_address_zip_code").click(function(){
    input_address_zip_change();
  });
  function ad_type_change(){
    if( $('#ad_ad_type').val() === 'Buy' )
    {	
	$('#checkoption').show();
    }
    else
    {
      $('#checkoption').hide();
    }

    if( $('select#brand_product_id').val() == '' )
    {
	$('.productcomponents').show();
    }
    else
    {
	$('.productcomponents').hide();
    }
    return false;
  };

  ad_type_change();
  $('#ad_ad_type').change(function(e) {        // Button which will activate our modal
     ad_type_change();
  });

  $('select#brand_product_id').change(function(e) {        // Button which will activate our modal
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




   
});
