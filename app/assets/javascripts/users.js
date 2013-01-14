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


$('#help').mouseover(function(e) {        // Button which will activate our modal
alert("alert" );
	$('#modal').show();
        return false;
    });
$('#help').mouseout(function(e) {        // Button which will activate our modal
alert("alert" );
	$('#modal').hide();
        return false;
});

$('#help').hover(function() {        // Button which will activate our modal
alert("alert" );
	$('#modal').show();
    }, function(e) {        // Button which will activate our modal
	$('#modal').hide();
    });

$('#ad_ad_type').change(function(e) {        // Button which will activate our modal
	if( $('#ad_ad_type').val() === 'Buy' )
	{
		$('#checkoption').show();
	}
	else
	{
		$('#checkoption').hide();
	}
        return false;
});

$('#help').keyup(function(e) {
	if(e.which===27){ $('#modal').hide(); } // 27 is the keycode for the Escape key
});


$('#commentslink').click(function(e) {        // Button which will activate our modal
alert("here");
	var chart;
	chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                type: 'bar'
            },
            title: {
                text: 'Bid Price'
            },
            
            xAxis: {
                labels: {
                    formatter: function() {
                        return this.value; // clean, unformatted number for year
                    }
                }
            },
            yAxis: {
                title: {
                    text: 'Price'
                },
                labels: {
                    formatter: function() {
                        return this.value;
                    }
                }
            },
            tooltip: {
                formatter: function() {
                    return Highcharts.numberFormat(this.y, 0);
                }
            },
            plotOptions: {
                bar: {
                    pointStart: 1,
                    marker: {
                        enabled: false,
                        symbol: 'circle',
                        radius: 1,
                        states: {
                            hover: {
                                enabled: true
                            }
                        }
                    }
                }
            },
            series: [{
                name: 'Prices',
                data: $(this).attr('data-points');
            }]
        });
   });
});
