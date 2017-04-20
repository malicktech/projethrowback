

$(document).ready(function(){

  
	var catCmsDir = "index.php?id_cms_category";
	var dir = baseDir + catCmsDir;
    var cms_services = baseDir  + 'index.php?id_cms=7&controller=cms&id_lang='+ langue_id;
    var cms_lien_legaux = baseDir + 'index.php?id_cms=12&controller=cms&id_lang='+ langue_id;
    $("a[href^='"+dir+"']").addClass("CategoryCms");
    var els =  document.getElementsByClassName("CategoryCms");
	for (var i = 0, l = els.length; i < l; i++) {
  		var el = els[i];       
          if (el.href.indexOf("id_cms_category=3") > -1) {
               el.onclick = function(){el.href = cms_services}();
          }
          else if (el.href.indexOf("id_cms_category=4") > -1) {
               el.onclick = function(){el.href = cms_lien_legaux}();
          }
	} 

   /* *********************************** home  .js ***************************/

    if (window.matchMedia("(max-width: 768px)").matches) {
      $('.menu_vertical').removeClass('hidden').addClass('show');

        $(window).scroll(function (event) {
          var scroll_mob = $(window).scrollTop();
          if(scroll_mob>0){
              $('header .nav').removeClass('show').addClass('hidden');
              $(".logo-throwback").attr("src",url_logo_simple);
              $(".logo-throwback").css("margin-top", "20px");
        }
        else{
              $('header .nav').removeClass('hidden').addClass('show');
              $(".logo-throwback").attr("src",url_logo_simple);
              fullPage();

        }
      });

  } else {

        $('#left_column').hide();
        $('#center_column').removeClass('col-sm-9').addClass('col-sm-12');

        scrollAction();
    }

    /* *********************************** Define .js ***************************/

    $( ".toggle_menu" ).click(function(e) {
         e.preventDefault();
         $('#left_column #block_top_menu ul.sf-menu').show();
         if ($( "#toggleMenu" ).hasClass("maxi")){
                minimizePage();
         }
         else if ($( "#toggleMenu" ).hasClass("mini")){
                fullPage();
         }
    });

    $('.product_list li').hover(function () {
        $( this).addClass('hovered');
    }, function () {
        $( this).removeClass('hovered');
    });

    /*************************************** Authentification ***************************/
    function isFrance() {
      return ($( '#id_country option:selected' ).text().toLowerCase()=="france");
    }
    $.formUtils.addValidator({
      name : 'check_password',
      validatorFunction : function(value) {
        return value.length >= 6 && value.length <= 24;
      }
    });
    $.formUtils.addValidator({
      name : 'check_name',
      validatorFunction : function(value) {
        var regex = /^[a-zA-Zéèïçà^îù¨ê-]+[ \-']?[[a-zA-Zéèïçà^îù¨ê-]+$/;
        return ( (value.length >= 2 && value.length <= 28) && (regex.test(value))) 
      }
    });    

    /*************************************** Adresse ***************************/
    
    $.formUtils.addValidator({
      name : 'check_num_voie',
      validatorFunction : function(value) {
        return ( (value.length >= 1 && value.length <= 5) && (parseFloat(value) == parseInt(value)) && !isNaN(value)) 
      }
    });
    $.formUtils.addValidator({
      name : 'check_alpha_num',
      validatorFunction : function(value) {
        return ( (value.length >= 2 && value.length <= 38) && (value.toString().match(/^[A-Za-z0-9éèïçà^îù¨-ê-]+$/)))  
      }
    });
    $.formUtils.addValidator({
      name : 'check_phone',
      validatorFunction : function(value) {
        if(isFrance()){
          start = value.substr(0, 2);
          var array = ["01", "02", "03", "04", "05", "06", "07", "09"];
          return ( value.length == 10  && (parseFloat(value) == parseInt(value)) && !isNaN(value) && array.indexOf(start) >= 0) ;
        }
        else
          return ( (parseFloat(value) == parseInt(value)) && !isNaN(value) ) ;
        
      }
    });
    $.formUtils.addValidator({
      name : 'check_cp',
      validatorFunction : function(value) {
        if(isFrance())
          return ( value.length == 5  && (parseFloat(value) == parseInt(value)) && !isNaN(value)) 
        else 
          return ( (parseFloat(value) == parseInt(value)) && !isNaN(value) );
      }
    });


});


function fullPage() {
  if (window.matchMedia("only screen and (min-width: 480px) and  (max-width: 768px)").matches) {
      $(".block_content").css("display", "none");
      $('#left_column').hide().css("position", "static");
  }else{
      $('#left_column').hide().css("position", "static");
      $('#center_column').removeClass('col-sm-9').addClass('col-sm-12').css("float", "left");
      $('#homepage-slider').removeClass('col-xs-9').addClass('col-xs-12').css("width", "100%").css("float", "left");
      $('.footer-container,#textSEO').css("width", "100%").css("float", "none");
      $('#toggleMenu').removeClass('mini').addClass('maxi');
     }
      $('#toggleMenu').removeClass('mini').addClass('maxi');
  }

function minimizePage() {

  if (window.matchMedia("only screen and (min-width: 480px) and (max-width: 768px)").matches) {
    $(".block_content").css("display", "block");
    $('#left_column').show().css("position", "fixed").css("top", "96px").css("z-index", "9999").css("width", "90%").css("background-color", "#fff").css("height", "100%");
  }
  else{
      $('#left_column').show().css("position", "fixed").css("top", "80px").css("z-index", "5003").css("width", "20%");
      $('#center_column').removeClass('col-sm-12').addClass('col-sm-9').css("float", "right");
      $('#homepage-slider').removeClass('col-xs-12').addClass('col-xs-9').css("width", "75%").css("float", "right");
      $('.footer-container,#textSEO').css("width", "75%").css("float", "right");
  }
  $('#toggleMenu').removeClass('maxi').addClass('mini');
}

function scrollAction(){
  $(window).scroll(function (event) {
        var scroll = $(window).scrollTop();

        // JavaScript API built in for detecting media mobile
        var isMobile = window.matchMedia("only screen and (max-width: 480px)");

        if(scroll>0 && !isMobile.matches ){
            $('.menu_vertical').removeClass('hidden').addClass('show');
            $('header .nav').removeClass('show').addClass('hidden');
            $(".logo-throwback").attr("src",url_logo_simple);
            $("#header_logo").css("margin-top", "-20px");
        }
        else{
            $('header .nav').removeClass('hidden').addClass('show');
            $(".logo-throwback").attr("src",url_logo);
            $("#header_logo").css("margin-top", "-70px");
            fullPage();
        }
    });
}