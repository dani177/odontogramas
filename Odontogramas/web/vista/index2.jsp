<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Odontograma</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap-responsive.min.css">
        <!-- Bootstrap CSS fixes for IE6 -->
        <!--[if lt IE 7]><link rel="stylesheet" href="http://blueimp.github.com/cdn/css/bootstrap-ie6.min.css"><![endif]-->
        <!-- Bootstrap Image Gallery styles -->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-tagmanager.css">
        <style type="text/css">
            .resolucion{
                position: absolute;
                top:10px;
                right: 20px;
            }
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
            .navbar-fixed-top .brand {
                font-weight: bold;
                color: #000;
                text-shadow: 0 1px 0 rgba(255,255,255,.1), 0 0 30px rgba(255,255,255,.125);
                -webkit-transition: all .2s linear;
                -moz-transition: all .2s linear;
                transition: all .2s linear;
            }
            .sidebar-nav {
                padding: 9px 0;
            }

            .datepicker {
                background-color: #ffffff;
                border-color: #999;
                border-color: rgba(0, 0, 0, 0.2);
                border-style: solid;
                border-width: 1px;
                -webkit-border-radius: 4px;
                -moz-border-radius: 4px;
                border-radius: 4px;
                -webkit-box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                -moz-box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                -webkit-background-clip: padding-box;
                -moz-background-clip: padding-box;
                background-clip: padding-box;
                display: none;
                position: absolute;
                z-index: 900;
                margin-left: 0;
                margin-right: 0;
                margin-bottom: 18px;
                padding-bottom: 4px;
                width: 218px;
            }
            .datepicker .nav {
                font-weight: bold;
                width: 100%;
                padding: 4px 0;
                background-color: #f5f5f5;
                color: #808080;
                border-bottom: 1px solid #ddd;
                -webkit-box-shadow: inset 0 1px 0 #ffffff;
                -moz-box-shadow: inset 0 1px 0 #ffffff;
                box-shadow: inset 0 1px 0 #ffffff;
                zoom: 1;
            }
            .datepicker .nav:before, .datepicker .nav:after {
                display: table;
                content: "";
                zoom: 1;
                *display: inline;
            }
            .datepicker .nav:after {
                clear: both;
            }
            .datepicker .nav span {
                display: block;
                float: left;
                text-align: center;
                height: 28px;
                line-height: 28px;
                position: relative;
            }
            .datepicker .nav .bg {
                width: 100%;
                background-color: #fdf5d9;
                height: 28px;
                position: absolute;
                top: 0;
                left: 0;
                -webkit-border-radius: 4px;
                -moz-border-radius: 4px;
                border-radius: 4px;
            }
            .datepicker .nav .fg {
                width: 100%;
                position: absolute;
                top: 0;
                left: 0;
            }
            .datepicker .button {
                cursor: pointer;
                padding: 0 4px;
                -webkit-border-radius: 4px;
                -moz-border-radius: 4px;
                border-radius: 4px;
            }
            .datepicker .button:hover {
                background-color: #808080;
                color: #ffffff;
            }
            .datepicker .months {
                float: left;
                margin-left: 4px;
            }
            .datepicker .months .name {
                width: 72px;
                padding: 0;
            }
            .datepicker .years {
                float: right;
                margin-right: 4px;
            }
            .datepicker .years .name {
                width: 36px;
                padding: 0;
            }
            .datepicker .dow, .datepicker .days div {
                float: left;
                width: 30px;
                line-height: 25px;
                text-align: center;
            }
            .datepicker .dow {
                font-weight: bold;
                color: #808080;
            }
            .datepicker .calendar {
                padding: 4px;
            }
            .datepicker .days div {
                cursor: pointer;
                -webkit-border-radius: 4px;
                -moz-border-radius: 4px;
                border-radius: 4px;
            }
            .datepicker .days div:hover {
                background-color: #0064cd;
                color: #ffffff;
            }
            .datepicker .overlap {
                color: #bfbfbf;
            }
            .datepicker .today {
                background-color: #fee9cc;
            }
            .datepicker .selected {
                background-color: #bfbfbf;
                color: #ffffff;
            }


        </style>

        <!-- Le javascript
           ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="assets/js/bootstrap-datepicker.js"></script>
        <script src="assets/js/jquery.validate.js"></script>
        <script src="assets/js/jquery.metadata.js"></script>
        <script src="assets/js/jquery.ba-hashchange.js"></script>

        <script src='<%=request.getContextPath()%>/js/bootstrap-tagmanager.js' type='text/javascript'></script>
        <script type="text/javascript">
            $(function(){
                location = "/Odontogramas/#inicio";
                $(".nav-list >li > a").click(function(ev){
                    $(this).parents("li").siblings().removeClass("active");
                    $(this).parents("li").addClass("active");
                    location = $(this).attr("href");
                });
                
                var hash = location.hash;
                if(hash == "#inicio"){
                    $("a[href='#listaPacientes']").click();
                }
                
                
                
                $(window).hashchange(function(){
                    var hash = location.hash;
                    
                    
                    if(hash == "#inicio"){
                        $("a[href='#listaPacientes']").click();
                    }
                
                    if(hash == "#listaPacientes"){
                        $.ajax({ 
                            type: "POST", 
                            url: "/Odontogramas/vista/paciente/listar.jsp", 
                            success: function(data) 
                            { 
                                $("#contenido").html(data);
                                       
                            } //fin success
                        }); //fin del $.ajax
                    }
                    else{
                        if(hash == "#nuevoPaciente"){
                            $.ajax({ 
                                type: "POST", 
                                url: "/Odontogramas/vista/paciente/crear.jsp", 
                                success: function(data) 
                                { 
                                    $("#contenido").html(data);
                                       
                                } //fin success
                            }); //fin del $.ajax
                      
                        }else{
                           
                            if(hash.indexOf("#verPaciente")!=-1){
                                var cual = hash.split("&");
                                var url3 = "<%=request.getContextPath()%>/formController?action=";
                                url3 = url3.concat(cual[0].substring(1),"&id=",cual[1]);
                                $.ajax({ 
                                    type: "POST", 
                                    url: url3,
                                    success: function(data) 
                                    { 
                                        $.ajax({ 
                                            type: "POST", 
                                            url: "/Odontogramas/vista/paciente/editar.jsp",
                                            success: function(data) 
                                            {   
                                                $(this).parents("li").siblings().removeClass("active");
                                                $(this).parents("li").addClass("active");
                                                $("#contenido").html(data);
                                       
                                            } //fin success
                                        }); //fin del $.ajax
                                    } //fin success
                                }); //fin del $.ajax
                            }else{
                                
                                if(hash.indexOf("#listaConsultas")!=-1){
                                    var cual = hash.split("&");
                                    var url3 = "<%=request.getContextPath()%>/formController?action=";
                                    url3 = url3.concat(cual[0].substring(1),"&id=",cual[1]);
                                      
                                    $.ajax({ 
                                        type: "POST", 
                                        url: url3,
                                        success: function(data) 
                                        { 
                                            $.ajax({ 
                                                type: "POST", 
                                                url: "/Odontogramas/vista/consulta/listar.jsp",
                                                success: function(data) 
                                                {  $(".nav-list >li > a").hide();
                                                    $(".nav-list").append('<li><a href="#menuPacientes" title="Menú de pacientes">Atras</a></li>'                                                        
                                                        +'<li><a href="#nuevaConsulta">Nueva Consulta</a></li>'
                                                        +'<li class="active"><a href="#listaConsultas">Lista de Consultas</a></li>');
                                                    
                                                    $("#contenido").html(data);
                                                    $(".nav-list >li > a").click(function(ev){
                                                        $(this).parents("li").siblings().removeClass("active");
                                                        $(this).parents("li").addClass("active");
                                                        location = $(this).attr("href");
                                                    });
                                       
                                                } //fin success
                                            }); //fin del $.ajax
                                        } //fin success
                                    }); //fin del $.ajax
                                }
                                
                                else{
                                    if(hash=="#nuevaConsulta"){
                                        $.ajax({ 
                                            type: "POST", 
                                            url: "<%=request.getContextPath()%>/formController?action=nuevaConsulta", 
                                            success: function() 
                                            { 
                                                $.ajax({ 
                                                    type: "POST", 
                                                    url: "/Odontogramas/vista/consulta/crear.jsp", 
                                                    success: function(data) 
                                                    { 
                                                        $("#contenido").html(data);
                                       
                                                    } //fin success
                                                }); //fin del $.ajax
                                       
                                            } //fin success
                                        }); //fin del $.ajax
                                       
                                            
                                    }else{
                                        if(hash == "#menuPacientes"){
                                            $(".nav-list >li >a").show();
                                            $(".nav-list >li").slice(3).remove();
                                            $("a[href='#listaPacientes']").click();
                                            
                                        }else{
                                            if(hash.indexOf("#verConsulta")!=-1){
                                                var cual = hash.split("&");
                                                var url3 = "<%=request.getContextPath()%>/formController?action=";
                                                url3 = url3.concat(cual[0].substring(1),"&id=",cual[1]);
                                                $.ajax({ 
                                                    type: "POST", 
                                                    url: url3,
                                                    success: function() 
                                                    { 
                                                        $.ajax({ 
                                                            type: "POST", 
                                                            url: "/Odontogramas/vista/consulta/ver.jsp",
                                                            success: function(data) 
                                                            {   $("#contenido").html(data);
                                                            } //fin success
                                                        }); //fin del $.ajax
                                                    }//fin success
                                                })//fin ajax
                                            }//fin if
                                            else{
                                                if(hash.indexOf("#editarConsulta")!=-1){
                                                    var cual = hash.split("&");
                                                    var url3 = "<%=request.getContextPath()%>/formController?action=";
                                                    url3 = url3.concat(cual[0].substring(1),"&id=",cual[1]);
                                                    $.ajax({ 
                                                        type: "POST", 
                                                        url: url3,
                                                        success: function() 
                                                        { 
                                                            $.ajax({ 
                                                                type: "POST", 
                                                                url: "/Odontogramas/vista/consulta/editar.jsp",
                                                                success: function(data) 
                                                                {   $("#contenido").html(data);
                                                                } //fin success
                                                            }); //fin del $.ajax
                                                        }//fin success
                                                    })//fin ajax
                                                }
                                            }
                                        }
                                        
                                    }
                                
                                }
                            }
                            
                        }   
                    }
                });
                
            });
        </script>

    </head>

    <body>




        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container" style="padding-top: 10px; padding-bottom: 10px;">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="#"><img src="<%=request.getContextPath()%>/img/LogoUdeC2.png" style="position: absolute;top:0;left:30px;"></img> Sistema para la Gesti&oacute;n de Informaci&oacute;n en el &Aacute;rea de Endodoncia</a>
                    <img class="resolucion span2" src="<%=request.getContextPath()%>/img/SIGIE.jpg" ></img>

                    <ul class="nav pull-right">
                        <li id="fat-menu" class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Bienvenido ${medico.getRowsByIndex()[0][1]} <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Cambiar Contrase&ntilde;a</a></li>
                                <li class="divider"></li>
                                <li><a href="<%=request.getContextPath()%>/cerrarSesion.jsp">Cerrar Sesi&oacute;n</a></li>
                            </ul>

                        </li>
                    </ul>

                </div>
            </div>
        </div>


        <div class="container-fluid" style="padding-top: 10px;">
            <div class="row-fluid">
                <div class="span3">
                    <div class="well sidebar-nav">
                        <ul class="nav nav-list">
                            <li class="nav-header">Men&uacute;</li>
                            <li><a href="#nuevoPaciente">Nuevo Paciente</a></li>
                            <li><a href="#listaPacientes">Lista de Pacientes</a></li>
                        </ul>
                    </div><!--/.well -->
                </div><!--/span-->
                <div id="contenido" class="span9">

                </div>
            </div><!--/row-->



            <footer>
                <p>&copy; Universidad de Cartagena 2012</p>
            </footer>

        </div><!--/.fluid-container-->



    </body>
</html>
