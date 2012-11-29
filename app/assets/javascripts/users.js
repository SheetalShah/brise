$(document).ready(function(){
  if($("#user_user_type").val() == "company"){ 
    $(".hidden_option").fadeIn('fast');   
  }
  else {
    $(".hidden_option").fadeOut('fast');
  }  

  $(document).on('change', '#user_user_type', function() { 
    if($("#user_user_type").val() == "company"){ 
      $(".hidden_option").fadeIn('fast');   
    }
    else {
      $(".hidden_option").fadeOut('fast');
    }            
  });        
 $.fx.speeds._default = 1000;
  $( "#dialog" ).dialog({
    autoOpen: false,
    show: "blind",
    hide: "explode"
  });
  // set effect from select menu value
  $( "#help" ).click(function() {
    $( "#dialog" ).dialog( "open" );
    return false;
  });
  $( "#dialog" ).hide();
});
