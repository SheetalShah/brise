$(document).ready(function(){
  $(".brandcontent").hide();
  //toggle the componenet with class msg_body
  $(".brandheading").click(function()
  {
	$(this).next(".brandcontent").slideToggle(500);
	//window.location = "/brand_products/" + $(this).attr('id');
  });


var text = $("a").contents().filter(function() {
  return this.nodeType == 3;
});
$(text).wrap("<span />");

$(".addmodel").click(function()
{
  $( ".addbrand_form").hide();
  $(".addmodel_form").show();

  //$( "#product").jstree( "create", null, "last", { "attr" : { "rel" : this.id.toString().replace( "add_", "" ) } });
});

$(".addbrand").click(function()
{
  $(".addmodel_form").hide();
  $( ".addbrand_form").hide();
  val = $(this).attr('data-id');
  $("#f"+val).show();

  //$( "#product").jstree( "create", null, "last", { "attr" : { "rel" : this.id.toString().replace( "add_", "" ) } });
});

$(".product")
	        // call `.jstree` with the options object
	        .jstree({
	            // the `plugins` array allows you to configure the active plugins on this instance
	            "plugins" : ["themes","html_data","ui","crrm","hotkeys"],
	            // each plugin you have included can have its own config object
	            //"core" : { "initially_open" : [ "root" ] },
	            // it makes sense to configure a plugin only if overriding the defaults
	        })
	        // EVENTS
	        // each instance triggers its own events - to process those listen on the container
	        // all events are in the `.jstree` namespace
	        // so listen for `function_name`.`jstree` - you can function names from the docs
	        .bind("loaded.jstree", function (event, data) {
	            // you get two params - event & data - check the core docs for a detailed description
		    $(".product").jstree("open_all");
		    jQuery("li").css('height', "auto");


	        });
$("#product")
	        // call `.jstree` with the options object
	        .jstree({
	            // the `plugins` array allows you to configure the active plugins on this instance
	            "plugins" : ["themes","html_data","ui","crrm","hotkeys"],
	            // each plugin you have included can have its own config object
	            //"core" : { "initially_open" : [ "root" ] },
	            // it makes sense to configure a plugin only if overriding the defaults
	        })
	        // EVENTS
	        // each instance triggers its own events - to process those listen on the container
	        // all events are in the `.jstree` namespace
	        // so listen for `function_name`.`jstree` - you can function names from the docs
	        .bind("loaded.jstree", function (event, data) {
	            // you get two params - event & data - check the core docs for a detailed description
		    $("#product").jstree("open_all");
	        });
	    
	    $("#product").bind("select_node.jstree", function (e, data) {
		$(".productconditional").hide();
		$(".addbrand").hide();
		$(".reviewfeed").hide();
		var pathnodes = data.inst.get_path(data.rslt.obj, true);
		$.each(pathnodes, function (k, v) {
		      if( k == 0 )
		      {
  		        $("#l"+v).show();
		      }

		      var vid = "#s"+v;
		      $(vid).show();
		      $("#review"+v).show();
		});
	    } );
	    // 4) when you are working with an event you can use a shortcut
	    $("#product").bind("open_node.jstree", function (e, data) {
	        // data.inst is the instance which triggered this event
	        //window.location = "/brand_products/" + $(this).attr('id');
//		data.inst.select_node("#phtml_2", true);
	    });

	   
    
	   $("#product").bind("refresh.jstree", function (e, data) {
	        $("#product").jstree("open_all");
	    });	
});


