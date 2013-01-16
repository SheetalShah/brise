function remove_fields(link) {
alert( "how r u?");
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up("tr.product").hide();
}

function add_fields(link, association, content) {
  if($("#user_user_type").val() == "company"){ 
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).up().insert({
      before: content.replace(regexp, new_id)
    });
  }
}

function runEffect() {
  // get effect type from
  var selectedEffect = $( "#effectTypes" ).val();
 
  // most effect types need no options passed by default
  var options = {};
  // some effects have required parameters
  if ( selectedEffect === "scale" ) {
    options = { percent: 100 };
  } 
  else if ( selectedEffect === "size" ) {
    options = { to: { width: 280, height: 185 } };
  }
 
  // run the effect
  $( "#effect" ).show( selectedEffect, options, 500, callback );
};
 
//callback function to bring a hidden box back
function callback() {
  setTimeout(function() {
    $( "#effect:visible" ).removeAttr( "style" ).fadeOut();
  }, 1000 );
};
 
// set effect from select menu value
$( "#help" ).click(function() {
  runEffect();
  return false;
});
 
