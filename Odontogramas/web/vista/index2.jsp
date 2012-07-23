<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Odontograma</title>
        <link rel="stylesheet" href="http://blueimp.github.com/cdn/css/bootstrap-responsive.min.css">
        <!-- Bootstrap CSS fixes for IE6 -->
        <!--[if lt IE 7]><link rel="stylesheet" href="http://blueimp.github.com/cdn/css/bootstrap-ie6.min.css"><![endif]-->
        <!-- Bootstrap Image Gallery styles -->
        <link rel="stylesheet" href="http://blueimp.github.com/cdn/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">


        <style type="text/css">
            body {
                padding-top: 60px;
                padding-bottom: 40px;
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
        <script src="assets/js/bootstrap-transition.js"></script>
        <script src="assets/js/bootstrap-alert.js"></script>
        <script src="assets/js/bootstrap-modal.js"></script>
        <script src="assets/js/bootstrap-carousel.js"></script>
        <script src="assets/js/bootstrap-dropdown.js"></script>
        <script src="assets/js/bootstrap-tab.js"></script>
        <script src="assets/js/bootstrap-button.js"></script>
        <script src="assets/js/bootstrap-datepicker.js"></script>
        <script src="assets/js/jquery.validate.js"></script>
        <script src="assets/js/jquery.metadata.js"></script>
        <script src="assets/js/jquery.ba-hashchange.js"></script>
        <script src="assets/js/bootstrap-typeahead.js"></script>
        <script type="text/javascript">
            $(function(){
                
                $(".nav-list >li > a").click(function(ev){
                    $(this).parents("li").siblings().removeClass("active");
                    $(this).parents("li").addClass("active");
                    location = $(this).attr("href");
                });
                
                var hash = location.hash;
                if(hash == "#inicio"){
                    $("#contenido").html("estamos en la pagina de inicio!!");
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
                        }
                            
                    }   
                }
               
                $(window).hashchange(function(){
                    var hash = location.hash;
                    
                    
                    if(hash == "#inicio"){
                        $("#contenido").html("estamos en la pagina de inicio!!");
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
                <div class="container">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="#">Odontogramas</a>

                    <ul class="nav">
                        <li class="active"><a href="#">Inicio</a></li>
                        <li><a href="#about">Acerca de</a></li>
                        <li><a href="#contact">Contactenos</a></li>
                    </ul>

                    <ul class="nav pull-right">
                        <li id="fat-menu" class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Bienvenido ${Usuario.nombreUsuario}<b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Cambiar Contrase&ntilde;a</a></li>
                                <li class="divider"></li>
                                <li><a href="<%=request.getContextPath()%>/cerrarSesion.jsp">Cerrar Sesion</a></li>
                            </ul>

                        </li>
                    </ul>

                </div>
            </div>
        </div>


        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span3">
                    <div class="well sidebar-nav">
                        <ul class="nav nav-list">
                            <li class="nav-header">Menu</li>
                            <li><a href="#nuevoPaciente">Nuevo Paciente</a></li>
                            <li><a href="#listaPacientes">Lista de Pacientes</a></li>
                        </ul>
                    </div><!--/.well -->
                </div><!--/span-->
                <div id="contenido" class="span9">
                    estamos en la pagina de inicio!!
                </div>
            </div><!--/row-->



            <footer>
                <p>&copy; Universidad de Cartagena 2012</p>
            </footer>

        </div><!--/.fluid-container-->



    </body>
</html>
