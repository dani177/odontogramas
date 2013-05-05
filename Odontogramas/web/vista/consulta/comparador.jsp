<%-- 
    Document   : comparador
    Created on : 29/04/2013, 09:03:30 AM
    Author     : Ususario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comparador</title>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
        <style>
            /* styles unrelated to zoom */
            * { border:0; margin:0; padding:0; }
            p { position:absolute; top:3px; right:28px; color:#555; font:bold 13px/1 sans-serif;}

            /* these styles are for the demo, but are not required for the plugin */
            .zoom {
                display:inline-block;
                position: relative;
            }

            /* magnifying glass icon */
            .zoom:after {
                content:'';
                display:block; 
                width:33px; 
                height:33px; 
                position:absolute; 
                top:0;
                right:0;
            }

            .zoom img {
                display: block;
            }

            .zoom img::selection { background-color: transparent; }

        </style>

        <style>

            #outer_container{
                position:fixed;
                bottom:-160px;	/*-160px to hide*/
                margin:0px 0px 10px 0px;
                height:130px;
                padding:0;
                -webkit-box-reflect:
                    below 5px -webkit-gradient(
                    linear,
                    left top,
                    left bottom,
                    from(transparent),
                    color-stop(0.6, transparent),
                    to(rgb(18, 18, 18))
                    );
            }
            #thumbScroller{
                position:absolute;
                left:0;
                overflow:hidden;
            }
            #thumbScroller .container{
                position:relative;
                left:0;
            }
            #thumbScroller .content{
                float:left;
            }
            #thumbScroller .content div{
                margin:2px;
                height:100%;
            }
            #thumbScroller img,
            img.clone{
                border:5px solid #fff;
                height:120px;
            }
            #thumbScroller a{
                padding:2px;
                outline:none;
            }
            .fp_overlay{
                width:100%;
                height:100%;
                position:fixed;
                top:0px;
                left:0px;
                background:transparent url(images/icons/pattern2.png) repeat-x bottom left;
            }
            .fp_loading{
                display:none;
                position:fixed;
                top:50%;
                left:50%;
                margin:-35px 0px 0px -35px;
                background:#000 url(images/icons/loader.gif) no-repeat center center;
                width:70px;
                height:70px;
                -moz-border-radius:10px;
                -webkit-border-radius:10px;
                border-radius:10px;
                z-index:999;
                opacity:0.7;
            }
            .fp_next,
            .fp_prev{
                width:50px;
                height:50px;
                position:fixed;
                top:50%;
                margin-top:-15px;
                cursor:pointer;
                opacity:0.5;
            }
            .fp_next:hover,
            .fp_prev:hover{
                opacity:0.9;
            }
            .fp_next{
                background:#000 url(images/icons/next.png) no-repeat center center;
                right:-50px;
            }
            .fp_prev{
                background:#000 url(images/icons/prev.png) no-repeat center center;
                left:-50px;
            }
            .fp_thumbtoggle{
                height:50px;
                background:#000;
                width:200px;
                text-align:center;
                letter-spacing:1px;
                text-shadow:1px 1px 1px #000;
                position:fixed;
                left:50%;
                margin-left:-100px;
                bottom:-50px;
                line-height:50px;
                cursor:pointer;
                opacity:0.8;
            }
            .fp_thumbtoggle:hover{
                opacity:1.0;
            }
            img.fp_preview{
                width:100%;
                height: 100%;
            }

            .draggable { width: 180px; height: 244px; padding: 0.5em; float: left; margin: 0 10px 10px 0;top:10px }
            #draggable, #draggable2 { margin-bottom:20px; }
            #draggable { cursor: n-resize; }
            #draggable2 { cursor: e-resize; }
            #containment-wrapper { width: 95%; height:350px; padding: 10px; }
            h3 { clear: left; }
        </style>
        <style>
            span.reference{
                font-family:Arial;
                position:fixed;
                right:10px;
                top:10px;
                font-size:10px;
            }
            span.reference a{
                color:#fff;
                text-transform:uppercase;
                text-decoration:none;
                text-shadow:1px 1px 1px #000;
                margin-left:20px;
            }
            span.reference a:hover{
                color:#ddd;
            }
            h1.title{
                width:919px;
                height:148px;
                position:fixed;
                top:10px;
                left:10px;
                text-indent:-9000px;
                background:transparent url(images/icons/title.png) no-repeat top left;
                z-index:2;
            }

        </style>

        <script type="text/javascript">
            $(function(){
                $.getJSON("/Odontogramas/cargar", function (result) {
                    if (result && result.length) {
                        for (var i = 0; i < result.length; i++) {
                            $("#contenedorCompara").append('<div class="content">'+
                                '<div><a href="#"><img src="'+result[i].url+'" alt="'+result[i].url+'" title="'+result[i].name+'" class="thumb" /></a></div>'+
                                '</div>');
                            
                        }
                    
                    }
                    
                });
                
            })
        </script>
        <script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
        <script type="text/javascript" src="js/jquery.zoom-min.js"></script>
        <script type="text/javascript">
            $(function() {
                sliderWidth=700;
                $('#thumbScroller').css('width',sliderWidth);
                var totalContent=0;
                $('#thumbScroller .content').each(function () {
                    totalContent+=$(this).innerWidth();
                    $('#thumbScroller .container').css('width',totalContent);
                });
                
                $('#thumbScroller  .thumb').each(function () {
                    $(this).fadeTo(fadeSpeed, 0.6);
                });
                var fadeSpeed=200;
                $('#thumbScroller .thumb').hover(
                function(){ //mouse over
                    $(this).fadeTo(fadeSpeed, 1);
                },
                function(){ //mouse out
                    $(this).fadeTo(fadeSpeed, 0.6);
                }
            );
                
                $('#thumbScroller').mousemove(function(e){
                    if($('#thumbScroller  .container').width()>sliderWidth){
                        var mouseCoords=(e.pageX - 530);
                        var mousePercentX=mouseCoords/sliderWidth;
                        var destX=-(((totalContent-(sliderWidth))-sliderWidth)*(mousePercentX));
                        var thePosA=mouseCoords-destX;
                        var thePosB=destX-mouseCoords;
                        var animSpeed=600; //ease amount
                        var easeType='easeOutCirc';
                        if(mouseCoords==destX){
                            $('#thumbScroller .container').stop();
                        }
                        else if(mouseCoords>destX){
                            //$('#thumbScroller .container').css('left',-thePosA); //without easing
                            $('#thumbScroller .container').stop().animate({left: -thePosA}, animSpeed,easeType); //with easing
                        }
                        else if(mouseCoords<destX){
                            //$('#thumbScroller .container').css('left',thePosB); //without easing
                            $('#thumbScroller .container').stop().animate({left: thePosB}, animSpeed,easeType); //with easing
                        }
                    }
                });
                
            });
          
        </script>

    </head>
    <body>
        <div class="row">
            <div class="span10">
                <div id="containment-wrapper">
                    <div id="draggable3" class="draggable ui-widget-content">
                        <div id="cuadro1" class="zoom"></div>
                    </div>
                    <div id="draggable5" class="draggable ui-widget-content">
                        <div id="cuadro2" class="zoom"></div>
                        <div id="slider" style="position: absolute;top:60px;right: -15px" class="ui-slider ui-slider-vertical ui-widget ui-widget-content ui-corner-all">
                            <a href="#" class="ui-slider-handle ui-state-default ui-corner-all"></a>
                        </div>    
                    </div>
                </div>
            </div>
            <div class="span2">
                <div style="width: 300px;height: 300px;">
                    <h4 id="labelComentario">Comparacion</h4>
                    <textarea id="comentario" name="comentario" rows="9" cols="8"></textarea>
                    <button type="button" class="btn" id="guardarComentario" data-original-title="Guardar comentario" data-loading-text="Guardando comentarios..." autocomplete="off">Guardar comentario</button>
                </div>
            </div>
        </div>



        <div id="fp_gallery" class="fp_gallery">
            <img src="images/1.jpg" alt="" class="fp_preview" style="display:none;"/>
            <div id="fp_loading" class="fp_loading"></div>
            <div id="fp_next" class="fp_next"></div>
            <div id="fp_prev" class="fp_prev"></div>
            <div id="outer_container">
                <div id="thumbScroller">
                    <div class="container" id="contenedorCompara" >

                    </div>
                </div>
            </div>
            <div id="fp_thumbtoggle" class="fp_thumbtoggle">View Thumbs</div>
        </div>
        <script type="text/javascript">
            $(function(){
                
                $("#guardarComentario").live("click",function(){
                    $(this).button('loading');
                    $.ajax({
                        type: 'POST',
                        url: "<%=request.getContextPath()%>/formController?action=agregarComentario",
                        data: "comentario=" + $("#comentario").val() + "&rx1="+$("#draggable3").find("h5").html()+ "&rx2="+$("#draggable5").find("h5").html(),
                        success: function() {
                            setTimeout(function() {
                                $("#guardarComentario").button('reset');
                            }, 500);
                        } //fin success
                    }); //fin $.ajax
                })
                
                setTimeout(function() {
                
                    var slide_int = null;

                    function update_slider(){
                        var offset = $('.ui-slider-handle').offset();
                        var value = $('#slider').slider('option', 'value');
                        $( "#draggable5" ).css("opacity",value/10);
                        //console.log('Value is '+value);
                    
                    }

                    $('#slider').slider({
                        animate: true,
                        step: 1,
                        min: 3,
                        value: 5,
                        orientation: 'vertical',
                        max: 10,
                        start: function(event, ui){
                            slide_int = setInterval(update_slider, 10);	
                        },
                        slide: function(event, ui){
                            setTimeout(update_slider, 10);  
                        },
                        stop: function(event, ui){
                            clearInterval(slide_int);
                            slide_int = null;
                        }
                    });	
                
                
                
                    //current thumb's index being viewed
                    var current			= -1;
                    //cache some elements
                    var $btn_thumbs = $('#fp_thumbtoggle');
                    var $loader		= $('#fp_loading');
                    var $btn_next		= $('#fp_next');
                    var $btn_prev		= $('#fp_prev');
                    var $thumbScroller	= $('#thumbScroller');
				
                    //total number of thumbs
                    var nmb_thumbs		= $thumbScroller.find('.content').length;
				
                    //preload thumbs
                    var cnt_thumbs 		= 0;
                    for(var i=0;i<nmb_thumbs;++i){
                        var $thumb = $thumbScroller.find('.content:nth-child('+parseInt(i+1)+')');
                        $('<img/>').load(function(){
                            ++cnt_thumbs;
                            if(cnt_thumbs == nmb_thumbs)
                            //display the thumbs on the bottom of the page
                                showThumbs(2000);
                        }).attr('src',$thumb.find('img').attr('src'));
                    }
				
				
                
				
                    //clicking on a thumb...
                    $thumbScroller.find('.content').bind('click',function(e){
                        var $currImage = null;
                        var $currImage2 = null;
                        if(!$("#draggable3").find("img").length){
                            $currImage2 = $('#cuadro1'); 
                            $currImage = $('#draggable3'); 
                            $($currImage).
                                append("<a class='ui-icon ui-icon-closethick' style='position:absolute;right:-8px;top:-9px;' title='Delete this image' href=''>Delete image</a>");
                                
                        }else{
                            if(!$("#draggable5").find("img").length){
                                $currImage2 = $('#cuadro2'); 
                                $currImage = $('#draggable5'); 
                                $($currImage).
                                    append("<a class='ui-icon ui-icon-closethick' style='position:absolute;right:-8px;top:-9px;' title='Delete this image' href=''>Delete image</a>");
                                    
                            }
                        }
                        if($currImage!=null){    
                            var $content= $(this);
                            var $elem 	= $content.find('img');
                            //keep track of the current clicked thumb
                            //it will be used for the navigation arrows
                            current 	= $content.index()+1;
                            //get the positions of the clicked thumb
                            var pos_left 	= $elem.offset().left;
                            var pos_top 	= $elem.offset().top;
                            //clone the thumb and place
                            //the clone on the top of it
                            var $clone 	= $elem.clone()
                            .addClass('clone')
                            .css({
                                'position':'fixed',
                                'left': pos_left + 'px',
                                'top': pos_top + 'px'
                            }).insertAfter($('BODY'));
					
                            var windowW = $(window).width();
                            var windowH = $(window).height();
				
                            //animate the clone to the center of the page
                            $clone.stop()
                            .animate({
                                'left': windowW/2 + 'px',
                                'top': windowH/2 + 'px',
                                'margin-left' :-$clone.width()/2 -5 + 'px',
                                'margin-top': -$clone.height()/2 -5 + 'px'
                            },500,
                            function(){
                                var $theClone 	= $(this);
                                var ratio		= $clone.width()/120;
                                var final_w		= 400*ratio;
						
                                $loader.show();
                       
                      
                                $("<img class='fp_preview'/>").load(function(){
                                    var $newimg 		= $(this);
                                    var nombre = $newimg.attr("src").split("/");
                                    var nom = nombre[nombre.length-1].split(".");
                                    
                                    $($currImage).append("<h5 class='rx' style='position:absolute;right:70px;top:-30px;'>"+nom[0]);
                                    
                                    if($($currImage).attr("id")=="draggable5"){
                                        $.ajax({
                                            type: 'POST',
                                            url: "<%=request.getContextPath()%>/formController?action=obtenerComentario",
                                            data: "rx1="+$("#draggable3").find("h5").html()+ "&rx2="+$("#draggable5").find("h5").html(),
                                            dataType: "json",
                                            success: function(data) {
                                                if(data!=null){
                                                $.each(data['0']["comentario"], function(index, value) {
                                                    var b = data['0']["comentario"][index]['comentario'];
                                                    $("#comentario").val(b);
                                                });    
                                                }else{
                                                    $("#comentario").val("");
                                                }
                                                
                                                setTimeout(function() {
                                                    
                                                    $("#guardarComentario").button('reset');
                                                }, 500);
                                            } //fin success
                                        }); //fin $.ajax  
                                    }
                                    
                                    $newimg.appendTo($currImage2);
                                    $('.zoom').zoom({ on:'click' });
                                    $loader.hide();
                                    //expand clone
                                    $theClone.animate({
                                        'opacity'		: 0,
                                        'top'			: windowH/2 + 'px',
                                        'left'			: windowW/2 + 'px',
                                        'margin-top'	: '-200px',
                                        'margin-left'	: -final_w/2 + 'px',
                                        'width'			: final_w + 'px',
                                        'height'		: '400px'
                                    },1000,function(){$(this).remove();});
                                    //now we have two large images on the page
                                    //fadeOut the old one so that the new one gets shown
                                    /* $currImage.fadeOut(2000,function(){
                                         $(this).remove();
                                     });*/
                            
                                }).attr('src',$elem.attr('alt'));
                                
                                //expand the clone when large image is loaded
                       
                            });
                            //hide the thumbs container
                            //hideThumbs();
                            e.preventDefault();
                        }
                        
                    });
				
                    //clicking on the "show thumbs"
                    //displays the thumbs container and hides
                    //the navigation arrows
                    /*$btn_thumbs.bind('click',function(){
                                            showThumbs(500);
                                            hideNav();
                                    });*/
				
                    /*function hideThumbs(){
                                            $('#outer_container').stop().animate({'bottom':'-160px'},500);
                                            showThumbsBtn();
                                    }*/

                    function showThumbs(speed){
                        $('#outer_container').stop().animate({'bottom':'0px'},speed);
                        hideThumbsBtn();
                    }
				
                    function hideThumbsBtn(){
                        $btn_thumbs.stop().animate({'bottom':'-50px'},500);
                    }

                    function showThumbsBtn(){
                        $btn_thumbs.stop().animate({'bottom':'0px'},500);
                    }

                    //events for navigating through the set of images
                    /* $btn_next.bind('click',showNext);
                     $btn_prev.bind('click',showPrev);*/
				
                    //the aim is to load the new image,
                    //place it before the old one and fadeOut the old one
                    //we use the current variable to keep track which
                    //image comes next / before
              
		
                }, 200);
            });
        </script>

        <script>
                
            $(function() {
                $( "#draggable3" ).draggable({ cursor: "move", containment: "#containment-wrapper", scroll: false });
                $( "#draggable5" ).draggable({ cursor: "move", containment: "#containment-wrapper", scroll: false });
                //
            });
        </script>
    </body>
</html>
