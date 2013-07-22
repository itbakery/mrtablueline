// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
// raphael  morris
//
//= require jquery
//= require jquery.fancybox.pack
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require twitter/bootstrap
//= require ckeditor/init
//= require jquery_nested_form
//= require bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require jquery.purr
//= require best_in_place
//= require raphael
//= require morris
//= require_tree .

jQuery.noConflict();

$(window).load(function() {
    //Flexslider 2
  jQuery('#activityflexslider').flexslider({
    animation: "slide",
    animationSpeed: 2000,
    controlsContainer: ".flex-container",
  });
    //Flexslider 2
  jQuery('#mainflexslider').flexslider({
    animation: "slide",
    controlsContainer: ".flex-container",
    slideshow: false,
    start: function(slider) {
           setTimeout(slider.resume, 3000);
        }
  });

  jQuery('#project_startat').datepicker();
  jQuery('#project_endat').datepicker();
  jQuery('.best_in_place').best_in_place()

});


$(document).ready(function() {


   if ($('textarea').length > 0) {
     var data = $('textarea');
     $.each(data, function(i) {
       CKEDITOR.replace(data[i].id);
     });
   }

    $("i").mouseover(function(){
      $("i").css("background-color","white");
    });


    //tab
    $('#effectTab a:first').tab('show');
    //image stretch
    $(".fancybox").fancybox({
        helpers : {
            overlay : {
                css : {
                    'background' : 'rgba(58, 42, 45, 0.95)'
                }
            }
        }
    });

   $('#searchdate').datepicker();

   $('.advancesearch').on('click', function(e) {
    e.preventDefault();
    var $this = $(this);
    var $collapse = $this.closest('.collapse-group').find('.collapse');
    $collapse.collapse('toggle');
   });


   var slide = false;
   var height = $('#footer_content').height();
   $('#footer_button').click(function() {
       var docHeight = $(document).height();
       var windowHeight = $(window).height();
       var scrollPos = docHeight - windowHeight + height;
       $('#footer_content').animate({ height: "toggle"}, 1000);
       if(slide == false) {
           if($.browser.opera) {
               $('html').animate({scrollTop: scrollPos+'px'}, 1000);
           } else {
               $('html, body').animate({scrollTop: scrollPos+'px'}, 1000);
           }
           slide = true;
       } else {
           slide = false;
       }
   });

   //tootip

    $("a").tooltip();

});


