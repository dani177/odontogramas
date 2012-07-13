<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Odontograma</title>
        <link href="assets/css/bootstrap.css" rel="stylesheet"> 
        <link href="assets/css/docs2.css" rel="stylesheet"> 


        <style type="text/css">
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
            .sidebar-nav {
                padding: 9px 0;
            }
            #notificaciones {
                bottom: 5px;
                position: fixed; 
                right: 10px;
                width: 250px;
                z-index: 9999;
            }
        </style>
        <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
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
                    var div = $(this).attr("href");
                    $(div).show();
                
                });
                
                location ="/Odontogramas/#inicio";
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
                            }else{
                                if(hash.indexOf("#subirRadiografias")!=-1){
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
                                                url: "/Odontogramas/upload.jsp",
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
