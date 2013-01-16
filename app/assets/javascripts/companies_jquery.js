function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("true");
  $(link).closest("tr.product").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

$(document).ready(function(){

function init() {
  if( $('input#manufactured').attr('checked') == "checked" )
  {
     $('div.manufactured').show();
     $('div.manufactured').find("a#add_manufactured").click();
     
  }
  else
  {
     $('div.manufactured').find("a#remove_manufactured" ).click();
     $('div.manufactured').hide();
  }

  if( $('input#retail').attr('checked') == "checked" )
  {
     $('div.retail').show();
     $('div.retail').find("a#add_retail").click();
     
  }
  else
  {
     $('div.retail').find("a#remove_retail" ).click();
     $('div.retail').hide();
  }
}
init();

$("input:checkbox").click(function(){
  id = $(this).attr('id');
  if( $(this).attr('checked') == "checked" )
  {
     $('div.'+ id).show();
     $('div.'+ id).find("a#add_" + id).click();
     
  }
  else
  {
     $('div.'+ id).find("a#remove_" + id ).click();
     $('div.'+ id).hide();
  }

});
});
function runEffect() {
  // run the effect
  $( "#effect" ).show( "blind", {}, 500, callback );
};
 
//callback function to bring a hidden box back
function callback() {
  setTimeout(function() {
    $( "#effect:visible" ).removeAttr( "style" ).fadeOut();
  }, 1000 );
};
 

 
