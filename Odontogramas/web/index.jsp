<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" 
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
        HttpSession session1 = request.getSession();
        String aux = (String) session1.getAttribute("logueado");
        if (aux == null || aux.equals("")) {
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("/vista/index2.jsp");
            rd.forward(request, response);

        }

    %>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Odontogramas</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- Le styles -->
        <link href="assets/css/bootstrap.css" rel="stylesheet"> 
        <link href="assets/css/docs.css" rel="stylesheet"> 
        <style type="text/css">
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
        </style>
        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="assets/js/jquery.js"></script>
        <script src="assets/js/jquery.validate.js"></script>
        <script src="assets/js/jquery.metadata.js"></script>
        <script src="assets/js/bootstrap-transition.js"></script>
        <script src="assets/js/bootstrap-alert.js"></script>
        <script src="assets/js/bootstrap-modal.js"></script>
        <script src="assets/js/bootstrap-dropdown.js"></script>
        <script src="assets/js/bootstrap-button.js"></script>

        <script type="text/javascript">
            $(function(){
                
                ("a[href='']")
                $("#myModalRegistro").modal();
                
                $('.dropdown-menu').find('form').click(function (e) {
                    var target = $(e.target);
                    if($(target).attr("class")!="close"){
                        e.stopPropagation();
                    }
                    
                });	 
                
                $("#formulario_login").validate({
                    errorLabelContainer:".alert-error",
                    submitHandler: function() {
                        setTimeout(function () {
                            $.ajax({
                                url: '/Odontogramas/loginController',
                                data: 'un='+ $('#codigo').val() +'&pw=' + $('#pass').val(),
                                type: 'post',
                                success: function(msg){
                                   
                                    if(msg == 0) 
                                    {   
                                        document.location='/Odontogramas/';
                                    }
                                    else 
                                    { 
                                    }
                                } //fin success
                            });//fin ajax
                            
                        }, 400);//fin timeOut
                            
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
                        <li><a href="#registro">Crear cuenta</a></li>
                        <li id="fat-menu" class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Iniciar Sesion <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <form class="well" id="formulario_login" action="">
                                    <div class='alert alert-error' style="display: none">
                                        <a data-dismiss='alert' class='close'>×</a>  
                                        <strong>Error!</strong>Usuario y/o Contrase&ntilde;a incorrecto(s)
                                    </div>
                                    <label>Usuario</label>
                                    <input type="text" id="codigo" name="codigo" class="span3 {required:true}" />
                                    <label>Contrase&ntilde;a</label>
                                    <input type="password" id="pass" name="pass" class="span3 {required:true}" />
                                    <label><a href="#">Olvidó su contrase&ntilde;a?</a></label>
                                    <button type="submit" class="btn btn-primary">Entrar</button>
                                </form><!--/form-->
                            </ul>

                        </li>
                    </ul>

                </div>
            </div>
        </div>

        <div class="container" style="margin-top:-20px;">
            <div class="logo">
                <img class="center" alt="logo" src="images/logo2.png">
            </div>
            <div class="hero-unit" style="margin-top: -5px;">
                <h1>Bienvenido!</h1>
                <p>Eum hinc argumentum te, no sit percipit adversarium, ne qui feugiat persecuti. Odio omnes scripserit ad est, ut vidit lorem maiestatis his, putent mandamus gloriatur ne pro. Oratio iriure rationibus ne his, ad est corrumpit splendide. Ad duo appareat moderatius, ei falli tollit denique eos.!</p>
                <p><a class="btn btn-large btn-primary" href="about">Leer m&aacute;s »</a></p>
            </div>
            <div class="row">
                <div class="span4">
                    <h2>Sitios</h2>
                    <ul class="thumbnails">
                        <li class="span4"><a class="thumbnail" href="sites">
                                <img alt="" src="images/odon.png"></a></li></ul>
                    <p>La Facultad de Odontología de la Universidad de Cartagena forma un profesional con conocimientos, habilidades y destrezas integrales en las áreas propias del saber. </p>
                    <p><a href="sites" class="btn">Ver »</a></p>
                </div>
                <div class="span4">
                    <h2>Logros</h2>
                    <ul class="thumbnails">
                        <li class="span4"><a class="thumbnail" href="tutorials">
                                <img alt="" src="images/logros.png"></a></li></ul>        
                    <p>Como una forma de propiciar su relación con el entorno, la Facultad de Odontología realiza su proyección a través de una serie de actividades de impacto social, dentro y fuera de su  planta física.</p>
                    <p><a href="tutorials" class="btn">Ver »</a></p>
                </div>
                <div class="span4">
                    <h2>Objetivos</h2>
                    <ul class="thumbnails">
                        <li class="span4">
                            <a class="thumbnail" href="code">
                                <img alt="" src="images/boca.jpg"></a></li></ul>        
                    <p>Formar de manera integral Odontólogos especialistas en el área de Estomatología y Cirugía Oral que suplan las necesidades en las zonas rurales y urbanas, en cuanto a  la resolución de patologías del sistema estomatognático, logrando reducir así las incidencias de estas alteraciones y sus consecuencia.</p>
                    <p><a href="code" class="btn">Ver »</a></p>
                </div>
            </div>
            <footer>
                <hr>
                <p class="left">&copy; Universidad de Cartagena 2012</p>

            </footer>
        </div> <!-- /container -->
        <div class="modal hide fade" id="myModalRegistro">
            <div class="modal-header">
                <a data-dismiss="modal" class="close">×</a>
                <h3>Atención!</h3>
            </div>
            <div class="modal-body">
                <h4>Evaluación información numérica.</h4>
                <br>
                    <p>La información numérica se ha evaluado satisfactoriamente .</p>
            </div>
            <div class="modal-footer">
                <a class="btn btn-primary" data-dismiss="modal" href="#">Cerrar</a>
            </div>
        </div>
    </body>
</html>
