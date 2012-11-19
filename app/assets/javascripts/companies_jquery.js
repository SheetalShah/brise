function remove_fields(link) {
alert( "remove it" );
  $(link).prev("input[type=hidden]").val("true");
  $(link).closest("div.row-fluid").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

function runEffect() {
  // run the effect
alert("now showing");
  $( "#effect" ).show( "blind", {}, 500, callback );
};
 
//callback function to bring a hidden box back
function callback() {
  setTimeout(function() {
    $( "#effect:visible" ).removeAttr( "style" ).fadeOut();
  }, 1000 );
};
 

 
