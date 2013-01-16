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

    $('#help').hover(function() {        // Button which will activate our modal
      $('#dialog').show();
    }, function(e) {        // Button which will activate our modal
	$('#dialog').hide();
    });
 
});
